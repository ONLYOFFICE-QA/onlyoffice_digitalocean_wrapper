# frozen_string_literal: true

module OnlyofficeDigitaloceanWrapper
  # Get image, droplet by metadata
  module Getters
    def get_image_id_by_name(image_name)
      all_droplets = @client.images.all
      image = all_droplets.find { |x| x.name == image_name }
      raise DigitalOceanImageNotFound, image_name if image.nil?

      OnlyofficeLoggerHelper.log("get_image_id_by_name(#{image_name}): #{image.id}")
      image.id
    end

    # Get droplet by its name
    # @param [String] droplet_name
    # @return [DropletKit::Droplet] droplet
    def droplet_by_name(droplet_name)
      retry_exception do
        droplets = @client.droplets.all
        droplets.find { |x| x.name == droplet_name }
      end
    end

    def get_droplet_id_by_name(droplet_name)
      droplet = droplet_by_name(droplet_name)
      if droplet.nil?
        OnlyofficeLoggerHelper.log("get_droplet_id_by_name(#{droplet_name}): not found any droplets")
        nil
      else
        OnlyofficeLoggerHelper.log("get_droplet_id_by_name(#{droplet_name}): #{droplet.id}")
        droplet.id
      end
    end

    def get_droplet_ip_by_name(droplet_name)
      droplet = droplet_by_name(droplet_name)
      if droplet.nil?
        OnlyofficeLoggerHelper.log("There is no created droplet with name: #{droplet_name}")
        return
      end
      retry_exception do
        ip = public_ip(droplet)
        OnlyofficeLoggerHelper.log("get_droplet_ip_by_name(#{droplet_name}): #{ip}")
        ip
      end
    end

    def get_droplet_status_by_name(droplet_name)
      droplet = droplet_by_name(droplet_name)
      if droplet.nil?
        OnlyofficeLoggerHelper.log("get_droplet_status_by_name(#{droplet_name}): not found any droplets")
        nil
      else
        retry_exception do
          status = droplet.status
          status = :locked if droplet.locked
          OnlyofficeLoggerHelper.log("get_droplet_status_by_name(#{droplet_name}): #{status}")
          status
        end
      end
    end

    # Get public ip of droplet
    # @param [DropletKit] droplet to get ip
    # @return [String] public ip
    def public_ip(droplet)
      networks = droplet.networks.to_a.first
      public_network = networks.find { |net| net.type == 'public'}
      public_network.ip_address
    end
  end
end
