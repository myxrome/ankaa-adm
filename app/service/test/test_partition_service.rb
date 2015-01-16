class TestPartitionService

  def initialize(partition)
    @partition = partition
  end

  def test(url)
    return if !url || url.empty?
    doc = Nokogiri::HTML(open(url))
    doc.css(@partition.scope).map { |part|
      yield(part)
    }.first(5)
  end

end