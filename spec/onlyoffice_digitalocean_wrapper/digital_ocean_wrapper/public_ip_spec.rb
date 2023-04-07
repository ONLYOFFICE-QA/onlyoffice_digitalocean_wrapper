# frozen_string_literal: true

require 'resolv'
require 'spec_helper'

describe OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper, '#public_ip' do
  let(:digital_ocean) { described_class.new }

  it 'public_ip for existing droplet returns an IP' do
    droplet = digital_ocean.droplet_by_name(existing_droplet)
    expect(digital_ocean.public_ip(droplet)).to match(Resolv::IPv4::Regex)
  end
end
