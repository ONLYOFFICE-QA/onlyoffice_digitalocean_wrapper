require 'droplet_kit'
require 'onlyoffice_logger_helper'
require_relative 'digitalocean_wrapper/digitalocean_exceptions'
require_relative 'digitalocean_wrapper/exceptions_retryer'
require_relative 'digitalocean_wrapper/getters'
require_relative 'digitalocean_wrapper/power_actions'
require_relative 'digitalocean_wrapper/token_methods'

module OnlyofficeDigitaloceanWrapper
  # Class for wrapping DigitalOcean API gem
  class DigitalOceanWrapper
    include Getters
    include ExceptionsRetryer
    include PowerActions
    include TokenMethods

    DROPLET_SIZES = %w[512mb 1gb 2gb 4gb 8gb 16gb 32gb 48gb 64gb].freeze
    attr_accessor :client

    def initialize(access_token = nil)
      access_token ||= read_token
      @client = DropletKit::Client.new(access_token: access_token)
      raise ArgumentError, 'DigitalOceanWrapper: Your Access Token is Incorrect' unless correct_access_token?
    end

    def current_kernel(droplet_name)
      droplet = droplet_by_name(droplet_name)
      kernel_name = droplet.kernel.name
      OnlyofficeLoggerHelper.log("get_droplet_kernel_by_name(#{droplet_name}): #{kernel_name}")
      kernel_name
    end

    def wait_until_droplet_have_status(droplet_name, status = 'active')
      timeout = 300
      counter = 0
      while get_droplet_status_by_name(droplet_name) != status && counter < timeout
        counter += 10
        sleep 10
        OnlyofficeLoggerHelper.log("waiting for droplet (#{droplet_name}) to have "\
                                   "status: #{status} for #{counter} seconds of #{timeout}")
      end
      get_droplet_status_by_name(droplet_name)
    end

    def kernels_of_droplet(droplet_name)
      droplet_id = get_droplet_id_by_name(droplet_name)
      kernels = client.droplets.kernels(id: droplet_id).to_a
      OnlyofficeLoggerHelper.log("Got kernels_of_droplet(#{droplet_name})")
      kernels
    end

    def restore_image_by_name(image_name = 'nct-at-stable',
                              droplet_name = image_name,
                              region = 'nyc3',
                              size = '2gb',
                              tags: nil)
      unless DROPLET_SIZES.include?(size)
        raise DigitalOceanSizeNotSupported,
              "There is no support of droplets with size: #{size}"
      end
      image_id = get_image_id_by_name(image_name)
      droplet = DropletKit::Droplet.new(name: droplet_name,
                                        region: region,
                                        image: image_id.to_i,
                                        tags: Array(tags),
                                        size: size)
      created = @client.droplets.create(droplet)
      OnlyofficeLoggerHelper.log("restore_image_by_name(#{image_name}, #{droplet_name})")
      if created.is_a?(String)
        raise "Problem, while creating '#{droplet_name}' from image '#{image_name}'\n" \
              "Error: #{created}"
      end
      created
    end

    def destroy_droplet_by_name(droplet_name = 'nct-at1')
      droplet_id = get_droplet_id_by_name(droplet_name)
      client.droplets.delete(id: droplet_id)
      OnlyofficeLoggerHelper.log("destroy_droplet_by_name(#{droplet_name})")
      wait_until_droplet_have_status(droplet_name, nil)
    end
  end
end
