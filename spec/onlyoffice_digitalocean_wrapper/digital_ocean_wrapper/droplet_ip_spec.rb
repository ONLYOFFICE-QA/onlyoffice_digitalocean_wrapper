# frozen_string_literal: true

require 'resolv'
require 'spec_helper'

describe OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper, '#droplet_ip' do
  let(:digital_ocean) { described_class.new }

  it 'droplet_ip for public networks returns an IP' do
    droplet = digital_ocean.droplet_by_name(existing_droplet)
    expect(digital_ocean.droplet_ip(droplet, 'public')).to match(Resolv::IPv4::Regex)
  end

  it 'droplet_ip for private networks returns nil' do
    droplet = digital_ocean.droplet_by_name(existing_droplet)
    expect(digital_ocean.droplet_ip(droplet, 'private')).to be_nil
  end
end
