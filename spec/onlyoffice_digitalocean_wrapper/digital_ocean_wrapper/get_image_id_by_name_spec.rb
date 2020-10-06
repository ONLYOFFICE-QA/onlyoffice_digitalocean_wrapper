# frozen_string_literal: true

require 'spec_helper'

existing_image_name = 'nct-at-docker'
non_existing_image_name = 'incorrect-image-name'

describe OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper, '#get_image_id_by_name' do
  let(:digital_ocean) { described_class.new }

  it 'get_image_id_by_name' do
    expect(digital_ocean.get_image_id_by_name(existing_image_name)).to be_a(Integer)
  end

  it 'get_image_id_by_name for non-existing image' do
    expect { digital_ocean.get_image_id_by_name(non_existing_image_name) }
      .to raise_error(OnlyofficeDigitaloceanWrapper::DigitalOceanImageNotFound, non_existing_image_name)
  end
end
