class TestPartitionService

  def initialize(partition)
    @partition = partition
  end

  def test(url)
    return if url.blank?
    doc = Nokogiri::HTML(open(url))
    doc.css(@partition.scope).map { |part|
      yield(part)
    }.first(5)
  end

end