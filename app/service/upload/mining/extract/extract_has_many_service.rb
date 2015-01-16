class ExtractHasManyService < BaseExtractService

  def extract_value_from_part(scope)
    order = 0
    @extractor.partitions.map { |partition|
      partition.perform(scope) { |part, value|
        value = @extractor.order? ? value.merge({order: (order += 1)}) : value
        @extractor.source? ? value.merge({source: part.css_path}) : value
      }
    }.flatten
  end

end