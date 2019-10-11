# frozen_string_literal: true

require 'spec_helper'

describe 'droplet kernels' do
  let(:digital_ocean) { OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper.new }

  it 'kernels_of_droplet' do
    expect(digital_ocean.kernels_of_droplet('testrail').first).to be_a(DropletKit::Kernel)
  end

  it 'current_kernel' do
    expect(digital_ocean.current_kernel('testrail')).to eq('Ubuntu 13.10 x64 vmlinuz-3.11.0-12-generic (277)')
  end
end
