class ExtractServiceFactory
  include Singleton

  def build_extract_service(extractor)
    "Extract#{extractor.type}Service".constantize.new(extractor)
  end

end