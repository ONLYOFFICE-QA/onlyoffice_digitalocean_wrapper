# frozen_string_literal: true

require 'spec_helper'

existing_image_name = 'nct-at-docker'
incorrect_droplet_size = '128gb'
digital_ocean = nil
droplet_name = "wrapper-test-#{SecureRandom.uuid}"

describe OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper, retry: 1 do
  before :all do
    digital_ocean = described_class.new
  end

  describe 'Restore image by name' do
    it 'restore_image_by_name with incorrect size' do
      expect do
        digital_ocean.restore_image_by_name(existing_image_name,
                                            droplet_name,
                                            'nyc3',
                                            incorrect_droplet_size)
      end.to raise_error(OnlyofficeDigitaloceanWrapper::DigitalOceanSizeNotSupported,
                         /There is no support of droplets with size: #{incorrect_droplet_size}/)
    end

    it 'restore_image_by_name' do
      digital_ocean.restore_image_by_name(existing_image_name, droplet_name)
      digital_ocean.wait_until_droplet_have_status(droplet_name)
      digital_ocean.destroy_droplet_by_name(droplet_name)
      expect(digital_ocean.get_droplet_id_by_name(droplet_name)).to be_nil
    end
  end

  describe 'Operation' do
    before :all do
      digital_ocean.restore_image_by_name(existing_image_name, droplet_name, tags: 'wrapper-tag')
      digital_ocean.wait_until_droplet_have_status(droplet_name)
    end

    after :all do
      digital_ocean.destroy_droplet_by_name(droplet_name) if digital_ocean.get_droplet_id_by_name(droplet_name)
    end

    it 'power_off_droplet' do
      digital_ocean.power_off_droplet(droplet_name)
      expect(digital_ocean.get_droplet_status_by_name(droplet_name)).to eq('off')
    end

    it 'power_on_droplet' do
      digital_ocean.power_on_droplet(droplet_name)
      expect(digital_ocean.get_droplet_status_by_name(droplet_name)).to eq('active')
    end

    it 'wait_until_droplet_have_status' do
      expect do
        digital_ocean.wait_until_droplet_have_status(droplet_name, 'destroyed', timeout: 10)
      end.to raise_error(OnlyofficeDigitaloceanWrapper::DropletOperationTimeout,
                         "#{droplet_name} was not destroyed for 10s")
    end

    it 'reboot_droplet' do
      digital_ocean.reboot_droplet(droplet_name)
      expect(digital_ocean.get_droplet_status_by_name(droplet_name)).to eq('active')
    end

    it 'check that instance have correct tag' do
      expect(digital_ocean.droplet_by_name(droplet_name).tags.first).to eq('wrapper-tag')
    end

    it 'destroy_droplet_by_name' do
      digital_ocean.destroy_droplet_by_name(droplet_name)
      expect(digital_ocean.get_droplet_id_by_name(droplet_name)).to be_nil
    end
  end
end
