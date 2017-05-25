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

    # Check if token is correct. If not trying to read new token
    # If reading failed - fail
    def assure_correct_token
      return if correct_access_token?
      @client = DropletKit::Client.new(access_token: DigitalOceanWrapper.read_token)
      return if correct_access_token?
      raise ArgumentError, 'Access token for DigitalOcean API is incorrect'
    end

    # Read access token from file system
    # @return [String] token
    def read_token
      return ENV['DO_ACCESS_TOKEN'] if ENV['DO_ACCESS_TOKEN']
      File.read(Dir.home + '/.do/access_token').delete("\n")
    rescue Errno::ENOENT
      raise Errno::ENOENT, "No access token found in #{Dir.home}/.do/ directory." \
      "Please create files #{Dir.home}/.do/access_token"
    end
  end
end
