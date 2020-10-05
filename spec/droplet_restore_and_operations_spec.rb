# frozen_string_literal: true

require 'spec_helper'

existing_image_name = 'nct-at-docker'
incorrect_droplet_size = '128gb'
digital_ocean = nil

describe OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper, retry: 1 do
  before :all do
    digital_ocean = OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper.new
  end

  describe 'Restore image by name' do
    it 'restore_image_by_name with incorrect size' do
      expect do
        digital_ocean.restore_image_by_name(existing_image_name,
                                            'wrapper-test',
                                            'nyc3',
                                            incorrect_droplet_size)
      end.to raise_error(OnlyofficeDigitaloceanWrapper::DigitalOceanSizeNotSupported,
                         /There is no support of droplets with size: #{incorrect_droplet_size}/)
    end

    it 'restore_image_by_name' do
      digital_ocean.restore_image_by_name(existing_image_name, 'wrapper-test')
      digital_ocean.wait_until_droplet_have_status('wrapper-test')
      digital_ocean.destroy_droplet_by_name('wrapper-test')
      expect(digital_ocean.get_droplet_id_by_name('wrapper-test')).to be_nil
    end
  end

  context 'Operation' do
    before :all do
      digital_ocean.restore_image_by_name(existing_image_name, 'wrapper-test', tags: 'wrapper-tag')
      digital_ocean.wait_until_droplet_have_status('wrapper-test')
    end

    it 'power_off_droplet' do
      digital_ocean.power_off_droplet('wrapper-test')
      expect(digital_ocean.get_droplet_status_by_name('wrapper-test')).to eq('off')
    end

    it 'power_on_droplet' do
      digital_ocean.power_on_droplet('wrapper-test')
      expect(digital_ocean.get_droplet_status_by_name('wrapper-test')).to eq('active')
    end

    it 'wait_until_droplet_have_status' do
      expect do
        digital_ocean.wait_until_droplet_have_status('wrapper-test', 'destroyed', timeout: 10)
      end.to raise_error(OnlyofficeDigitaloceanWrapper::DropletOperationTimeout,
                         'wrapper-test was not destroyed for 10s')
    end

    it 'reboot_droplet' do
      digital_ocean.reboot_droplet('wrapper-test')
      expect(digital_ocean.get_droplet_status_by_name('wrapper-test')).to eq('active')
    end

    it 'check that instance have correct tag' do
      expect(digital_ocean.droplet_by_name('wrapper-test').tags.first).to eq('wrapper-tag')
    end

    it 'destroy_droplet_by_name' do
      digital_ocean.destroy_droplet_by_name('wrapper-test')
      expect(digital_ocean.get_droplet_id_by_name('wrapper-test')).to be_nil
    end

    after :all do
      digital_ocean.destroy_droplet_by_name('wrapper-test') if digital_ocean.get_droplet_id_by_name('wrapper-test')
    end
  end
end
