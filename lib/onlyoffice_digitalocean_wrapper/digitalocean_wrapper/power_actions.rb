# frozen_string_literal: true

module OnlyofficeDigitaloceanWrapper
  # Actions with power (turn on/off, reboot)
  module PowerActions
    def power_off_droplet(droplet_name)
      droplet_id = get_droplet_id_by_name(droplet_name)
      client.droplet_actions.power_off(droplet_id: droplet_id)
      wait_until_droplet_have_status(droplet_name, 'off')
    end

    def power_on_droplet(droplet_name)
      droplet_id = get_droplet_id_by_name(droplet_name)
      client.droplet_actions.power_on(droplet_id: droplet_id)
      wait_until_droplet_have_status(droplet_name)
    end

    def reboot_droplet(droplet_name)
      droplet_id = get_droplet_id_by_name(droplet_name)
      client.droplet_actions.reboot(droplet_id: droplet_id)
      wait_until_droplet_have_status(droplet_name)
    end
  end
end
