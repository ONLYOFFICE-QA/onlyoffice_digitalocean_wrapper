# frozen_string_literal: true

require 'spec_helper'

describe OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper, '#project_by_name' do
  existing_project = 'QA Automation'
  nonexisting_project = 'random_pr'
  let(:digital_ocean) { described_class.new }

  it 'project_by_name with existing name' do
    expect(digital_ocean.project_by_name(existing_project)).to be_a(DropletKit::Project)
  end

  it 'project_by_name with non-existing name' do
    expect(digital_ocean.droplet_by_name(nonexisting_project)).to be_nil
  end

  it 'get_project_by_name with existing name' do
    expect(digital_ocean.get_project_id_by_name(existing_project)).to be_a(String)
  end

  it 'get_project_by_name with nonexisting name' do
    expect(digital_ocean.get_project_id_by_name(nonexisting_project)).to be_nil
  end
end
