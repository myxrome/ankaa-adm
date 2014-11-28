module MappingsHelper

  def mapping_source_path(mapping)
    if mapping.source_type == 'Scraper'
      scraper_path(mapping.source)
    else
      transformer_path(mapping.source)
    end
  end

end