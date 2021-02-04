# frozen_string_literal: true

require 'logger'

module OnlyofficeDigitaloceanWrapper
  # Logger module for logging stuff
  module LoggerWrapper
    # @return [Logger] default logger
    def logger
      @logger ||= Logger.new($stdout)
    end
  end
end
