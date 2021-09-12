# frozen_string_literal: true

require 'net-telnet'

require_relative 'ssh_checker/ssh_checker_exceptions'

module OnlyofficeDigitaloceanWrapper
  # Class for check if ssh can be connected
  class SshChecker
    include LoggerWrapper
    # @return [String] ip of server
    attr_reader :ip

    # @param ip [String] ip of server to check
    def initialize(ip)
      @ip = ip
    end

    # Wait until ssh server on server is up and available for connection
    # @param timeout [Integer] how much we should wait for connection
    # @return [void]
    def wait_until_ssh_up(timeout: 60)
      wait_between_tries = 5
      tries = timeout / wait_between_tries
      tries.times do |try|
        return true if ssh_up?

        logger.info("SSH on `#{@ip}` is not up. Waited for #{try * wait_between_tries} seconds of #{timeout}")
        sleep wait_between_tries
      end
      raise SshCheckerSshUpTimeout, "SSH on `#{@ip}` is not up for #{timeout} seconds. Could not proceed"
    end

    # Check is ssh available for connection right now
    # @return [Boolean]
    def ssh_up?
      Net::Telnet.new('Host' => @ip,
                      'Timeout' => 1,
                      'Port' => 22)
      true
    rescue StandardError
      false
    end
  end
end
