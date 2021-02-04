# frozen_string_literal: true

require 'spec_helper'

describe OnlyofficeDigitaloceanWrapper::ExceptionsRetryer do
  include described_class
  include OnlyofficeDigitaloceanWrapper::LoggerWrapper

  it 'exception retryer retry exact specified times' do
    retries = 0
    begin
      retry_exception(retries: 1) do
        retries += 1
        raise DropletKit::Error
      end
    rescue DropletKit::Error
      logger.info('exception handled')
    end
    expect(retries).to eq(2)
  end
end
