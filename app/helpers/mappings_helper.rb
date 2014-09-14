module MappingsHelper

  def edit_mapping_path(mapping)
    if mapping.source_type == 'Scraper'
      edit_scraper_mapping_path(mapping.source, mapping)
    end
  end

  def mapping_source_name(mapping)
    source = mapping.source
    if source.respond_to?(:name)
      source.name
    end
  end

  def link_to_mapping_source(mapping)
    source = mapping.source
    if source.respond_to?(:name)
      link_to source.name, source
    end
  end

end
