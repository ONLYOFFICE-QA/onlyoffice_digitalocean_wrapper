module OnlyofficeDigitaloceanWrapper
  # Class raised if image with name is not found
  class DigitalOceanImageNotFound < StandardError
  end

  # Class raised if droplet size is not supported
  class DigitalOceanSizeNotSupported < StandardError
  end
end
