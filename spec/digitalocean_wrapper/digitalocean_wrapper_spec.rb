require 'rspec'
require_relative '../../testing_shared'

describe DigitalOceanWrapper do
  it 'check for correct load access token from file' do
    digital_ocean = DigitalOceanWrapper.new
    expect(digital_ocean.client.access_token).not_to be_empty
  end
end