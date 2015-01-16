class ExtractAttributeValueService < BaseExtractService

  def extract_value_from_part(scope)
    node = @extractor.element.empty? ? scope : scope.css(@extractor.element)
    node = node.first if node.is_a?(Nokogiri::XML::NodeSet)
    if node
      source = node[@extractor.attr]
      if source
        pattern = (@extractor.substring.nil? || @extractor.substring.empty?) ? '.*' : @extractor.substring
        @extractor.prefix + source.scan(/#{pattern}/).first + @extractor.postfix
      else
        raise "Empty result for attribute #{@extractor.attr} in element #{@extractor.element}"
      end
    else
      raise "Empty result for #{@extractor.element}"
    end
  end

end