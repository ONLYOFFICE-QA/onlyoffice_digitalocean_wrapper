# frozen_string_literal: true

module OnlyofficeDigitaloceanWrapper
  # Class raised if droplet ssh is not up for defined timeout
  class SshCheckerSshUpTimeout < StandardError
  end
end
