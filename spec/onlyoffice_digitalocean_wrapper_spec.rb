require 'spec_helper'

digital_ocean = nil
existing_image_name = 'nct-at-docker'
non_existing_image_name = 'incorrect-image-name'

describe OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper, retry: 1, use_private_key: true do
  before :all do
    digital_ocean = OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper.new
  end

  it 'check for incorrect access token - throwing exception' do
    expect { OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper.new('incorrect_key') }.to raise_error(ArgumentError)
  end

  it 'check for correct load access token from file' do
    expect(digital_ocean.client.access_token).not_to be_empty
  end

  describe 'get_image_id_by_name' do
    it 'get_image_id_by_name' do
      expect(digital_ocean.get_image_id_by_name(existing_image_name)).to be_a(Integer)
    end

    it 'get_image_id_by_name for nonexisting image' do
      expect { digital_ocean.get_image_id_by_name(non_existing_image_name) }
        .to raise_error(OnlyofficeDigitaloceanWrapper::DigitalOceanImageNotFound, non_existing_image_name)
    end
  end

  describe 'DigitalOceanWrapper#droplet_by_name' do
    it 'get_droplet_by_name with existing name' do
      expect(digital_ocean.droplet_by_name('testrail')).to be_a(DropletKit::Droplet)
    end

    it 'get_droplet_by_name with non-existing name' do
      expect(digital_ocean.droplet_by_name('not testrail')).to be_nil
    end
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

  it 'get_droplet_status_by_name nonexisting droplet' do
    expect(digital_ocean.get_droplet_status_by_name('not testrail')).to be_nil
  end

  it 'restore_image_by_name' do
    digital_ocean.restore_image_by_name(existing_image_name, 'wrapper-test')
    digital_ocean.wait_until_droplet_have_status('wrapper-test')
    digital_ocean.destroy_droplet_by_name('wrapper-test')
    expect(digital_ocean.get_droplet_id_by_name('wrapper-test')).to be_nil
  end

  it 'kernels_of_droplet' do
    expect(digital_ocean.kernels_of_droplet('testrail').first).to be_a(DropletKit::Kernel)
  end

  it 'current_kernel' do
    expect(digital_ocean.current_kernel('testrail')).to eq('Ubuntu 13.10 x64 vmlinuz-3.11.0-12-generic (277)')
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
