# frozen_string_literal: true

require 'spec_helper'

describe 'digitalocean access' do
  it 'check for incorrect access token - throwing exception' do
    expect { OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper.new('incorrect_key') }.to raise_error(ArgumentError)
  end

  it 'check for correct load access token from file' do
    expect(OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper.new.client.access_token).not_to be_empty
  end
end
