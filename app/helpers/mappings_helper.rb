module MappingsHelper

  def mapping_source_name(mapping)
    source = mapping.source
    if source.respond_to?(:name)
      mapping.source_type + ' ' + source.name
    else
      mapping.source_type + ' ' + source.key
    end
  end

  def link_to_mapping_source(mapping)
    source = mapping.source
    if source.respond_to?(:name)
      link_to source.name, source
    end
  end

end
