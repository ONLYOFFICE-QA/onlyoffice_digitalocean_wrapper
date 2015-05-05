require 'rspec'
require_relative '../../testing_shared'

describe DigitalOceanWrapper do
  it 'check for correct load access token from file' do
    digital_ocean = DigitalOceanWrapper.new
    expect(digital_ocean.client.access_token).not_to be_empty
  end

  it 'get_image_id_by_name' do
    digital_ocean = DigitalOceanWrapper.new
    expect(digital_ocean.get_image_id_by_name('nct-at-stable')).to be_a(Fixnum)
  end

  it 'get_droplet_by_name with existing name' do
    digital_ocean = DigitalOceanWrapper.new
    expect(digital_ocean.get_droplet_by_name('testrail')).to be_a(Fixnum)
  end

  it 'get_droplet_by_name with non-existing name' do
    digital_ocean = DigitalOceanWrapper.new
    expect(digital_ocean.get_droplet_by_name('not testrail')).to be_nil
  end

  it 'get_droplet_ip_by_name' do
    digital_ocean = DigitalOceanWrapper.new
    expect(digital_ocean.get_droplet_ip_by_name('testrail')).to eq('107.170.125.157')
  end
end