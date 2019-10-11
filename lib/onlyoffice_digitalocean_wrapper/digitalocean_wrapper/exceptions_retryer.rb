# frozen_string_literal: true

module OnlyofficeDigitaloceanWrapper
  # Module to ignore DigitalOcean exception if they happen irregularly
  module ExceptionsRetryer
    # Retry if exception happened
    # @param exception [Exception] exception to retry
    # @param retries [Integer] how much to retry
    # @param timeout [Integer] wait until next retry
    def retry_exception(exception = DropletKit::Error,
                        retries: 5,
                        timeout: 10)
      try = 0
      begin
        yield
      rescue exception => e
        try += 1
        OnlyofficeLoggerHelper.log("Error '#{exception}, #{e}' happened during "\
                                   "operation. Retrying #{try} of #{retries}")
        sleep timeout # Time to cooldown error
        try <= retries ? retry : raise
      end
    end
  end
end
