class ExtractPartitionService

  def initialize(partition)
    @partition = partition
  end

  def extract_partition_from_document(doc)
    doc.css(@partition.scope).map { |part|
      result = extract_data(part)
      block_given? ? yield(part, result) : result
    }
  end

  private
  def extract_data(part)
    @partition.extractors.map { |extractor|
      service = ExtractServiceFactory.build_extract_service(extractor)
      service.extract_data_from_part(part)
    }.reduce(:merge)
  end

end