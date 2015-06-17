require 'droplet_kit'
require_relative '../../helpers/logger_helper'
require_relative 'digitalocean_images'
require_relative 'digitalocean_kernels'

# Class for wrapping DigitalOcean API gem
class DigitalOceanWrapper
  attr_accessor :client

  def initialize(access_token = nil)
    if access_token.nil?
      begin
        access_token = File.read(Dir.home + '/.do/access_token').gsub("\n", '')
      rescue Errno::ENOENT
        raise Errno::ENOENT, "No access token found in #{Dir.home}/.do/ directory." \
        "Please create files #{Dir.home}/.do/access_token"
      end
    end
    @client = DropletKit::Client.new(access_token: access_token)
  end

  # Check if access token is correct
  # @return [true, false] result of check
  def correct_access_token?
    begin
      @client.droplets.all.first
    rescue TypeError
      return false
    end
    true
  end

  def get_image_id_by_name(image_name)
    all_droplets = @client.images.all
    image = all_droplets.find { |x| x.name == image_name }
    LoggerHelper.print_to_log("get_image_id_by_name(#{image_name}): #{image.id}")
    image.id
  end

  def get_droplet_by_name(droplet_name)
    droplets = @client.droplets.all
    droplet = droplets.find { |x| x.name == droplet_name }
    if droplet.nil?
      LoggerHelper.print_to_log("get_droplet_by_name(#{droplet_name}): not found any droplets")
      nil
    else
      LoggerHelper.print_to_log("get_droplet_by_name(#{droplet_name}): #{droplet.id}")
      droplet.id
    end
  end

  def get_droplet_ip_by_name(droplet_name)
    droplets = @client.droplets.all
    droplet = droplets.find { |x| x.name == droplet_name }
    ip = droplet.networks.first.first.ip_address
    LoggerHelper.print_to_log("get_droplet_ip_by_name(#{droplet_name}): #{ip}")
    ip
  end

  def current_kernel(droplet_name)
    droplets = @client.droplets.all
    droplet = droplets.find { |x| x.name == droplet_name }
    kernel_name = droplet.kernel.name
    LoggerHelper.print_to_log("get_droplet_kernel_by_name(#{droplet_name}): #{kernel_name}")
    kernel_name
  end

  def get_droplet_status_by_name(droplet_name)
    droplets = @client.droplets.all
    droplet = droplets.find { |x| x.name == droplet_name }
    if droplet.nil?
      LoggerHelper.print_to_log("get_droplet_status_by_name(#{droplet_name}): not found any droplets")
      nil
    else
      status = droplet.status
      status = :locked if droplet.locked
      LoggerHelper.print_to_log("get_droplet_status_by_name(#{droplet_name}): #{status}")
      status
    end
  end

  def wait_until_droplet_have_status(droplet_name, status = 'active')
    timeout = 300
    counter = 0
    while get_droplet_status_by_name(droplet_name) != status && counter < timeout
      counter += 1
      sleep 1
      LoggerHelper.print_to_log("waiting for droplet (#{droplet_name}) to have status: #{status} for #{counter} seconds of #{timeout}")
    end
    get_droplet_status_by_name(droplet_name)
  end

  def kernels_of_droplet(droplet_name)
    droplet_id = get_droplet_by_name(droplet_name)
    kernels = client.droplets.kernels(id: droplet_id).to_a
    LoggerHelper.print_to_log("Got kernels_of_droplet(#{droplet_name})")
    kernels
  end

  def change_kernel(droplet_name, kernel_name)
    droplet_id = get_droplet_by_name(droplet_name)
    all_kernels = kernels_of_droplet(droplet_name)
    needed_kernel_id = all_kernels.find { |cur_kernel| cur_kernel.name == kernel_name }.id
    client.droplet_actions.change_kernel(droplet_id: droplet_id, kernel: needed_kernel_id)
    wait_until_droplet_have_status(droplet_name)
  end

  def restore_image_by_name(image_name = 'nct-at-stable', droplet_name = image_name, region = 'nyc2', size = '2gb')
    image_id = get_image_id_by_name(image_name)
    droplet = DropletKit::Droplet.new(name: droplet_name, region: region, image: image_id.to_i, size: size)
    created = @client.droplets.create(droplet)
    LoggerHelper.print_to_log("restore_image_by_name(#{image_name}, #{droplet_name})")
    fail "Problem, while creating '#{droplet_name}' from image '#{image_name}'\n" \
    "Error: #{created}" if created.is_a?(String)
    created
  end

  def power_off_droplet(droplet_name)
    droplet_id = get_droplet_by_name(droplet_name)
    client.droplet_actions.power_off(droplet_id: droplet_id)
    wait_until_droplet_have_status(droplet_name, 'off')
  end

  def power_on_droplet(droplet_name)
    droplet_id = get_droplet_by_name(droplet_name)
    client.droplet_actions.power_on(droplet_id: droplet_id)
    wait_until_droplet_have_status(droplet_name)
  end

  def reboot_droplet(droplet_name)
    droplet_id = get_droplet_by_name(droplet_name)
    client.droplet_actions.reboot(droplet_id: droplet_id)
    wait_until_droplet_have_status(droplet_name)
  end

  def destroy_droplet_by_name(droplet_name = 'nct-at1')
    droplet_id = get_droplet_by_name(droplet_name)
    client.droplets.delete(id: droplet_id)
    LoggerHelper.print_to_log("destroy_droplet_by_name(#{droplet_name})")
    wait_until_droplet_have_status(droplet_name, nil)
  end
end
