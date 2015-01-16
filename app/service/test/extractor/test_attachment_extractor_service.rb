class TestAttachmentExtractorService < BaseTestExtractorService

  protected
  def wrap_test_value(value)
    "<a target='_blank' href='#{value}'>#{value}</a>"
  end

end