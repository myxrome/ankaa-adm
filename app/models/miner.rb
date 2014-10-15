class Miner < ActiveRecord::Base
  belongs_to :category
  has_many :miner_scrapers, inverse_of: :miner, dependent: :destroy
  has_many :scrapers, through: :miner_scrapers

  def perform
    source = self.miner_scrapers.map { |link|
      link.scraper.perform(link.url_prefix, link.url_postfix, link.limit)
    }.reduce(:merge)
    if source
      result = category.reconcile(source)
      MinerMailer.result_email(self, result).deliver
    else
      MinerMailer.error_email(self).deliver
    end
  end

end
