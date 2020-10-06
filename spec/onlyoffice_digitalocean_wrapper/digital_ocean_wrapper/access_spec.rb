# frozen_string_literal: true

require 'spec_helper'

describe OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper, '#access' do
  it 'check for incorrect access token - throwing exception' do
    expect { described_class.new('incorrect_key') }.to raise_error(ArgumentError)
  end

  it 'check for correct load access token from file' do
    expect(described_class.new.client.access_token).not_to be_empty
  end

  describe '#read_token' do
    it 'read_token raise exception if there is no file' do
      expect do
        wrapper = described_class.new
        wrapper.read_token(token_file_path: '/foo/bar', force_file_read: true)
      end.to raise_error(/No access token found in /)
    end
  end
end
