require 'digitalocean'
require_relative '../../helpers/logger_helper'
class DigitalOceanWrapper
  def initialize(client_id = nil, api_key = nil)
    if client_id.nil? || api_key.nil?
      begin
        client_id = File.read(Dir.home + '/.do/client_id.key').gsub("\n", '')
        api_key = File.read(Dir.home + '/.do/api.key').gsub("\n", '')
      rescue
        raise "No keys found in #{Dir.home}/.do/ directory. Please create files #{Dir.home}/.ec2/client_id.key and #{Dir.home}/.ec2/api.key"
      end
    end
    Digitalocean.client_id = client_id.gsub("\n", '')
    Digitalocean.api_key = api_key.gsub("\n", '')
  end

  def get_image_id_by_name(image_name)
    responce = Digitalocean::Image.all(filter: "my_images")
    image = responce.images.find {|x| x['name'] == image_name}
    image['id']
  end

  def get_droplet_by_name(droplet_name)
    begin
      responce = Digitalocean::Droplet.all
    rescue Exception => e
      LoggerHelper.print_to_log("get_droplet_by_name(#{droplet_name}) exception happened: #{e}")
      nil
    end
    droplet = responce.droplets.find {|x| x['name'] == droplet_name}
    if droplet.nil?
      nil
    else
      droplet['id']
    end
  end

  def get_droplet_ip_by_name(droplet_name)
    responce = Digitalocean::Droplet.all
    droplet = responce.droplets.find {|x| x['name'] == droplet_name}
    droplet['ip_address']
  end

  def get_droplet_status_by_name(droplet_name)
    responce = Digitalocean::Droplet.all
    droplet = responce.droplets.find {|x| x['name'] == droplet_name}
    if droplet.nil?
      nil
    else
      droplet['status']
    end
  end

  def wait_until_droplet_have_status(droplet_name, status = 'active')
    timeout = 300
    counter = 0
    while get_droplet_status_by_name(droplet_name) != status && counter < timeout
      counter += 1
      sleep 1
    end
    get_droplet_status_by_name(droplet_name)
  end

  def restore_image_by_name(image_name = 'nct-at1', droplet_name = image_name)
    id = get_image_id_by_name(image_name)
    create_result = Digitalocean::Droplet.create(name: droplet_name, size_id: 62, image_id: id, region_id: 4)
    fail "Problem, while creating '#{droplet_name}' from image ''#{image_name}' \nError: #{create_result.error_message}" if create_result.status == "ERROR"
  end

  def destroy_droplet_by_name(droplet_name = 'nct-at1')
    droplet_id = get_droplet_by_name(droplet_name)
    Digitalocean::Droplet.destroy(droplet_id)
    wait_until_droplet_have_status(droplet_name, nil)
  end
end
