# frozen_string_literal: true

require 'spec_helper'

describe OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper, '#ssh_helper' do
  not_existing_ssh = '123.123.123.123'
  existing_ssh = '127.0.0.1'

  let(:digital_ocean) { described_class.new }

  describe '#ssh_up?' do
    it 'ssh_up? return true for existing ssh server' do
      expect(digital_ocean).to be_ssh_up(existing_ssh)
    end

    it 'ssh_up? return false for not existing ssh server' do
      expect(digital_ocean).not_to be_ssh_up(not_existing_ssh)
    end
  end

  describe '#wait_until_ssh_up' do
    it 'wait_until_ssh_up wait for existing ssh' do
      expect(digital_ocean.wait_until_ssh_up(existing_ssh)).to be_truthy
    end

    it 'ssh_up? raise error for not existing ssh server' do
      expect { digital_ocean.wait_until_ssh_up(not_existing_ssh, 10) }
        .to raise_error(OnlyofficeDigitaloceanWrapper::DropletSshUpTimeout, /#{not_existing_ssh}/)
    end
  end
end
