class BaseTestExtractorService

  def initialize(extractor)
    @extractor = extractor
  end

  def test(url)
    partition_test = TestPartitionService.new(@extractor.partition)
    partition_test.test(url) { |scope|
      extractor_service = ExtractServiceFactory.build_extract_service(@extractor)
      value = extractor_service.extract_value_from_part(scope).to_s
      wrap_test_value(value)
    }
  end

  protected
  def wrap_test_value(value)
    value
  end

end