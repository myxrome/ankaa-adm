module PartitionsHelper

  def partition_source_path(partition)
    if partition.source_type == 'Scraper'
      scraper_path(partition.source)
    else
      extractor_path(partition.source)
    end
  end

end
