require 'rspec'
require_relative '../../testing_shared'

describe DigitalOceanWrapper, retry: 1 do
  let(:digital_ocean) { DigitalOceanWrapper.new }

  it 'check for correct load access token from file' do
    expect(digital_ocean.client.access_token).not_to be_empty
  end

  it 'get_image_id_by_name' do
    expect(digital_ocean.get_image_id_by_name('nct-at-stable')).to be_a(Fixnum)
  end

  it 'get_droplet_by_name with existing name' do
    expect(digital_ocean.get_droplet_by_name('testrail')).to be_a(Fixnum)
  end

  it 'get_droplet_by_name with non-existing name' do
    expect(digital_ocean.get_droplet_by_name('not testrail')).to be_nil
  end

  it 'get_droplet_ip_by_name' do
    expect(digital_ocean.get_droplet_ip_by_name('testrail')).to eq('107.170.125.157')
  end

  it 'get_droplet_status_by_name running droplet' do
    expect(digital_ocean.get_droplet_status_by_name('testrail')).to eq('active')
  end

  it 'get_droplet_status_by_name nonexisting droplet' do
    expect(digital_ocean.get_droplet_status_by_name('not testrail')).to be_nil
  end

  it 'restore_image_by_name' do
    digital_ocean.restore_image_by_name('nct-at-stable', 'wrapper-test')
    digital_ocean.wait_until_droplet_have_status('wrapper-test')
    digital_ocean.destroy_droplet_by_name('wrapper-test')
    expect(digital_ocean.get_droplet_by_name('wrapper-test')).to be_nil
  end

  it 'kernels_of_droplet' do
    expect(digital_ocean.kernels_of_droplet('testrail').first).to be_a(DropletKit::Kernel)
  end

  it 'current_kernel' do
    expect(digital_ocean.current_kernel('testrail')).to eq('Ubuntu 13.10 x64 vmlinuz-3.11.0-12-generic (277)')
  end

  it 'change_kernel' do
    digital_ocean.restore_image_by_name('nct-at-stable', 'wrapper-test')
    digital_ocean.wait_until_droplet_have_status('wrapper-test')
    expect(digital_ocean.current_kernel('wrapper-test')).not_to eq('Ubuntu 14.04 x64 vmlinuz-3.13.0-52-generic')
    digital_ocean.change_kernel('wrapper-test', 'Ubuntu 14.04 x64 vmlinuz-3.13.0-52-generic')
    expect(digital_ocean.current_kernel('wrapper-test')).to eq('Ubuntu 14.04 x64 vmlinuz-3.13.0-52-generic')
    digital_ocean.destroy_droplet_by_name('wrapper-test')
    expect(digital_ocean.get_droplet_by_name('wrapper-test')).to be_nil
  end

  it 'power_off_droplet' do
    digital_ocean.restore_image_by_name('nct-at-stable', 'wrapper-test')
    digital_ocean.wait_until_droplet_have_status('wrapper-test')
    digital_ocean.power_off_droplet('wrapper-test')
    expect(digital_ocean.get_droplet_status_by_name('wrapper-test')).to eq('off')
    digital_ocean.destroy_droplet_by_name('wrapper-test')
    expect(digital_ocean.get_droplet_by_name('wrapper-test')).to be_nil
  end

  it 'power_on_droplet' do
    digital_ocean.restore_image_by_name('nct-at-stable', 'wrapper-test')
    digital_ocean.wait_until_droplet_have_status('wrapper-test')
    digital_ocean.power_on_droplet('wrapper-test')
    expect(digital_ocean.get_droplet_status_by_name('wrapper-test')).to eq('active')
    digital_ocean.destroy_droplet_by_name('wrapper-test')
    expect(digital_ocean.get_droplet_by_name('wrapper-test')).to be_nil
  end

  it 'reboot_droplet' do
    digital_ocean.restore_image_by_name('nct-at-stable', 'wrapper-test')
    digital_ocean.wait_until_droplet_have_status('wrapper-test')
    digital_ocean.reboot_droplet('wrapper-test')
    expect(digital_ocean.get_droplet_status_by_name('wrapper-test')).to eq('active')
    digital_ocean.destroy_droplet_by_name('wrapper-test')
    expect(digital_ocean.get_droplet_by_name('wrapper-test')).to be_nil
  end
end
