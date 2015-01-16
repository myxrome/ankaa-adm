class TestExtractorServiceFactory
  include Singleton

  def build_test_extractor_service(extractor)
    "Test#{extractor.type}ExtractorService".constantize.new(extractor)
  end

end