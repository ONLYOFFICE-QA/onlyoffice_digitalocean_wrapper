require 'spec_helper'

describe 'DigitalOceanWrapper get droplet data' do
  let(:digital_ocean) { OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper.new }

  it 'get_droplet_by_name with existing name' do
    expect(digital_ocean.droplet_by_name('testrail')).to be_a(DropletKit::Droplet)
  end

  it 'get_droplet_by_name with non-existing name' do
    expect(digital_ocean.droplet_by_name('not testrail')).to be_nil
  end

  it 'get_droplet_id_by_name with existing name' do
    expect(digital_ocean.get_droplet_id_by_name('testrail')).to be_a(Integer)
  end

  it 'get_droplet_id_by_name with non-existing name' do
    expect(digital_ocean.get_droplet_id_by_name('not testrail')).to be_nil
  end

  it 'get_droplet_ip_by_name' do
    expect(digital_ocean.get_droplet_ip_by_name('testrail')).to eq('107.170.125.157')
  end

  it 'get_droplet_ip_by_name non existing name' do
    expect(digital_ocean.get_droplet_ip_by_name('not-exists')).to be_nil
  end

  it 'get_droplet_status_by_name running droplet' do
    expect(digital_ocean.get_droplet_status_by_name('testrail')).to eq('active')
  end

  it 'get_droplet_status_by_name non-existing droplet' do
    expect(digital_ocean.get_droplet_status_by_name('not testrail')).to be_nil
  end
end
