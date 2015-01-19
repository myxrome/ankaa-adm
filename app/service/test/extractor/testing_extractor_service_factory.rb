class TestingExtractorServiceFactory
  include Singleton

  def build_test_extractor_service(extractor)
    "Testing#{extractor.type}ExtractorService".constantize.new(extractor)
  end

end