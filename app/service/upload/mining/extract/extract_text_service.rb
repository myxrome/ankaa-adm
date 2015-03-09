class ExtractTextService < BaseExtractService

  def extract_value_from_part(scope)
    node = @extractor.element.blank? ? scope : scope.css(@extractor.element)
    node = node.first if node.is_a?(Nokogiri::XML::NodeSet)
    if node
      source = node.inner_text.strip if node.inner_text
      if source
        source.gsub(/#{@extractor.pattern}/, @extractor.replacement)
      else
        raise "Empty inner text for #{@extractor.element}" if @extractor.required?
        ''
      end
    else
      raise "Empty result for #{@extractor.element}" if @extractor.required?
      ''
    end
  end

end