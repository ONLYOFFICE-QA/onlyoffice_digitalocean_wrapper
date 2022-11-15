# frozen_string_literal: true

module OnlyofficeDigitaloceanWrapper
  # Get methods for IP
  module IpGetters
    # Get ip of droplet
    # @param [DropletKit] droplet to get ip
    # @param [String] network_type to get ip
    # @return [String] public ip
    def droplet_ip(droplet, network_type = 'public')
      networks = droplet.networks.to_a.first
      specific_network = networks.find { |net| net.type == network_type }
      return nil unless specific_network

      specific_network.ip_address
    end

    # Get public ip of droplet
    # @param [DropletKit] droplet to get ip
    # @return [String] public ip
    def public_ip(droplet)
      droplet_ip(droplet, 'public')
    end
  end
end
