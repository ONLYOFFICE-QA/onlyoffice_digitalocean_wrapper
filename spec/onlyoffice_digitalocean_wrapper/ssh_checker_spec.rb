# frozen_string_literal: true

require 'spec_helper'

describe OnlyofficeDigitaloceanWrapper::SshChecker do
  not_existing_ssh = described_class.new('123.123.123.123')
  existing_ssh = described_class.new('127.0.0.1')

  describe '#ssh_up?' do
    it 'ssh_up? return true for existing ssh server' do
      expect(existing_ssh).to be_ssh_up
    end

    it 'ssh_up? return false for not existing ssh server' do
      expect(not_existing_ssh).not_to be_ssh_up
    end
  end

  describe '#wait_until_ssh_up' do
    it 'wait_until_ssh_up wait for existing ssh' do
      expect(existing_ssh.wait_until_ssh_up).to be_truthy
    end

    it 'ssh_up? raise error for not existing ssh server' do
      expect { not_existing_ssh.wait_until_ssh_up(timeout: 10) }
        .to raise_error(OnlyofficeDigitaloceanWrapper::SshCheckerSshUpTimeout, /#{not_existing_ssh.ip}/)
    end
  end
end
