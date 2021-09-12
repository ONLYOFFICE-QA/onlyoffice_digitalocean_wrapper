# frozen_string_literal: true

require 'net-telnet'

module OnlyofficeDigitaloceanWrapper
  # Helper for working with ssh
  module SshHelper
    # Wait until ssh server on server is up and available for connection
    # @param ip [String] name of droplet to check
    # @param timeout [Integer] how much we should wait for connection
    # @return [void]
    def wait_until_ssh_up(ip, timeout = 60)
      wait_between_tries = 5
      tries = timeout / wait_between_tries
      tries.times do |try|
        return true if ssh_up?(ip)

        logger.info("SSH on `#{ip}` is not up. Waited for #{try * wait_between_tries} seconds of #{timeout}")
        sleep wait_between_tries
      end
      raise DropletSshUpTimeout, "SSH on `#{ip}` is not up for #{timeout} seconds. Could not proceed"
    end

    # Check is ssh available for connection right now
    # @param ip [String] ip of server to check
    # @return [Boolean]
    def ssh_up?(ip)
      Net::Telnet.new('Host' => ip,
                      'Timeout' => 1,
                      'Port' => 22)
      true
    rescue StandardError
      false
    end
  end
end
