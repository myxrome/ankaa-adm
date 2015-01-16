class BaseExtractService

  def initialize(extractor)
    @extractor = extractor
  end

  def extract_data_from_part(scope)
    {@extractor.key.to_sym => extract_value_from_part(scope)}
  end

  def extract_value_from_part(scope)
  end

end