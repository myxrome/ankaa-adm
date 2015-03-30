class ShowroomsScraper < SeedMigration::Migration
  def up
    showrooms = Partner.find_or_create_by! name: 'Showrooms' do |partner|
      partner.update_attributes! url: 'http://showrooms.ru/', active: true
    end

    Scraper.find_or_create_by! name: 'Showrooms' do |scraper|
      scraper.update_attributes! scope: '#product-list-container', selector: 'li',
                                 condition: '.label-title.size1', element: 'a', attr: 'href',
                                 source_pattern: '(.+)', source_replacement: 'http:\1',
                                 url_prefix: 'http://f.gdeslon.ru/f/68665fed66aeb62ca18b3fb9cdca84a74ca21af8?goto=', url_postfix: '', active: true
      Partition.create! name: 'Showrooms Body', scope: 'body', source: scraper, order: 1 do |partition|
        Extractor.create! [{partition: partition, type: 'ConstantValue', name: 'Partner', key: 'partner_id', value: showrooms.id,
                            element: '', attr: '', pattern: '', replacement: '', required: true},
                           {partition: partition, type: 'Text', name: 'Value Name', key: 'name', value: '',
                            element: '.subtitle', attr: '', pattern: '', replacement: '', required: false},
                           {partition: partition, type: 'Text', name: 'Value New Price', key: 'new_price', value: '',
                            element: 'div.product-detail-info .sum', attr: '', pattern: '\D', replacement: '', required: true},
                           {partition: partition, type: 'Text', name: 'Value Discount', key: 'discount', value: '',
                            element: '.gmask .label-title', attr: '', pattern: '\D', replacement: '', required: false},
                           {partition: partition, type: 'Text', name: 'Value Old Price', key: 'old_price', value: '',
                            element: 'div.product-detail-info .old-sum',
                            attr: '', pattern: '\D', replacement: '', required: true},
                           {partition: partition, type: 'Attachment', name: 'Value Thumb', key: 'thumb', value: '',
                            element: 'img[itemprop="image"]:nth-of-type(1)',
                            attr: 'src', pattern: '(.+)a60x90(.+)', replacement: 'http://showrooms.ru\11000x0\2', required: true}]

      end
    end
  end

  def down
    Scraper.where(name: 'Showrooms').each do |s|
      s.delete
    end
    Partner.where(name: 'Showrooms').each do |p|
      p.delete
    end
  end
end
