# frozen_string_literal: true

module OnlyofficeDigitaloceanWrapper
  # Get image, droplet by metadata
  module Getters
    def get_image_id_by_name(image_name)
      all_droplets = @client.images.all
      image = all_droplets.find { |x| x.name == image_name }
      raise DigitalOceanImageNotFound, image_name if image.nil?

      logger.info("get_image_id_by_name(#{image_name}): #{image.id}")
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

    # Get project by name
    # @param [String] project_name
    # @return [DropletKit::Project] object representing a project
    def project_by_name(project_name)
      retry_exception do
        projects = @client.projects.all
        projects.find { |x| x.name == project_name }
      end
    end

    # Get project id by name
    # @param [String] project_name
    # @return [nil, String] id of current project or nil is no project found
    def get_project_id_by_name(project_name)
      project = project_by_name(project_name)
      if project.nil?
        logger.info("get_project_id_by_name(#{project_name}): not found any projects")
        nil
      else
        logger.info("get_project_id_by_name(#{project_name}): #{project.id}")
        project.id
      end
    end

    # Return droplet id by it's name
    # @param droplet_name [String] name of droplet
    # @return [nil, Integer] id of droplet or nil is no one droplet found
    def get_droplet_id_by_name(droplet_name)
      droplet = droplet_by_name(droplet_name)
      if droplet.nil?
        logger.info("get_droplet_id_by_name(#{droplet_name}): not found any droplets")
        nil
      else
        logger.info("get_droplet_id_by_name(#{droplet_name}): #{droplet.id}")
        droplet.id
      end
    end

    # Return droplet ip by it's name
    # @param droplet_name [String] name of droplet
    # @return [String] ip of droplet
    def get_droplet_ip_by_name(droplet_name)
      droplet = droplet_by_name(droplet_name)
      if droplet.nil?
        logger.info("There is no created droplet with name: #{droplet_name}")
        return
      end
      retry_exception do
        ip = public_ip(droplet)
        logger.info("get_droplet_ip_by_name(#{droplet_name}): #{ip}")
        ip
      end
    end

    # Return droplet status by it's name
    # @param droplet_name [String] name of droplet
    # @return [Symbol] droplet status
    def get_droplet_status_by_name(droplet_name)
      droplet = droplet_by_name(droplet_name)
      if droplet.nil?
        logger.info("get_droplet_status_by_name(#{droplet_name}): not found any droplets")
        nil
      else
        retry_exception do
          status = droplet.status
          status = :locked if droplet.locked
          logger.info("get_droplet_status_by_name(#{droplet_name}): #{status}")
          status
        end
      end
    end
  end
end
