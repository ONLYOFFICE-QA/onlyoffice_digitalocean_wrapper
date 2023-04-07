# frozen_string_literal: true

require 'spec_helper'

describe OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper, '#droplet_by_name' do
  nonexisting_droplet = 'fake droplet name'
  let(:digital_ocean) { described_class.new }

  it 'get_droplet_by_name with existing name' do
    expect(digital_ocean.droplet_by_name(existing_droplet)).to be_a(DropletKit::Droplet)
  end

  it 'get_droplet_by_name with non-existing name' do
    expect(digital_ocean.droplet_by_name(nonexisting_droplet)).to be_nil
  end

  it 'get_droplet_id_by_name with existing name' do
    expect(digital_ocean.get_droplet_id_by_name(existing_droplet)).to be_a(Integer)
  end

  it 'get_droplet_id_by_name with non-existing name' do
    expect(digital_ocean.get_droplet_id_by_name(nonexisting_droplet)).to be_nil
  end

  it 'get_droplet_ip_by_name' do
    expect(digital_ocean.get_droplet_ip_by_name(existing_droplet)).to eq(existing_droplet_ip)
  end

  it 'get_droplet_ip_by_name non existing name' do
    expect(digital_ocean.get_droplet_ip_by_name(nonexisting_droplet)).to be_nil
  end

  it 'get_droplet_status_by_name running droplet' do
    expect(digital_ocean.get_droplet_status_by_name(existing_droplet)).to eq('active')
  end

  it 'get_droplet_status_by_name non-existing droplet' do
    expect(digital_ocean.get_droplet_status_by_name(nonexisting_droplet)).to be_nil
  end
end
