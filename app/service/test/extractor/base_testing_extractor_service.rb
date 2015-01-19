class BaseTestingExtractorService

  def initialize(extractor)
    @extractor = extractor
  end

  def test(url)
    return if url.blank?
    doc = Nokogiri::HTML(open(url))
    doc.css(@extractor.partition.scope).map { |part|
      extractor_service = ExtractServiceFactory.instance.build_extract_service(@extractor)
      value = extractor_service.extract_value_from_part(part).to_s
      wrap_test_value(value)
    }.first(5)
  end

  protected
  def wrap_test_value(value)
    value
  end

end