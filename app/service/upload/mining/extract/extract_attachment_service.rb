class ExtractAttachmentService < BaseExtractService

  def extract_value_from_part(scope)
    node = @extractor.element.blank? ? scope : scope.css(@extractor.element)
    node = node.first if node.is_a?(Nokogiri::XML::NodeSet)
    if node
      source = node[@extractor.attr]
      if source
        url = source.gsub(/#{@extractor.pattern}/, @extractor.replacement)
        URI.parse(url)
      else
        raise "Empty result for attribute #{@extractor.attr} in element #{@extractor.element}" if @extractor.required?
        ''
      end
    else
      raise "Empty result for #{@extractor.element}" if @extractor.required?
      ''
    end
  end

end