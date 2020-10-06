# frozen_string_literal: true

module OnlyofficeDigitaloceanWrapper
  # Methods to login in account
  module TokenMethods
    # Check if access token is correct
    # @return [true, false] result of check
    def correct_access_token?
      begin
        @client.droplets.all.first
      rescue DropletKit::Error
        return false
      end
      true
    end

    # Read access token from file system
    # @param token_file_path [String] path to token
    # @param force_file_read [True, False] should read from file be forced
    # @return [String] token
    def read_token(token_file_path: "#{Dir.home}/.do/access_token",
                   force_file_read: false)
      return ENV['DO_ACCESS_TOKEN'] if ENV['DO_ACCESS_TOKEN'] && !force_file_read

      File.read(token_file_path).delete("\n")
    rescue Errno::ENOENT
      raise Errno::ENOENT, "No access token found in #{token_file_path}. " \
      "Please create file #{token_file_path} with token"
    end
  end
end
