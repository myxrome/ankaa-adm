class LamodaScraper < SeedMigration::Migration
  def up
    butik = Partner.find_or_create_by! name: 'Butik' do |partner|
      partner.update_attributes! url: 'http://www.butik.ru/', active: true
    end

    Scraper.find_or_create_by! name: 'Butik' do |scraper|
      scraper.update_attributes! scope: '#catalogList', selector: '.main-data',
                                 condition: '.label_txt_discount', element: 'center a', attr: 'href',
                                 source_pattern: '(.+)', source_replacement: 'http://www.butik.ru\1',
                                 url_prefix: 'http://f.gdeslon.ru/f/529922dd7e855eda5817c6dc195f55f10c8bbb3c?goto=', url_postfix: '', active: true
      Partition.create! name: 'Butik Body', scope: 'body', source: scraper, order: 1 do |partition|
        Extractor.create! [{partition: partition, type: 'ConstantValue', name: 'Partner', key: 'partner_id', value: butik.id,
                            element: '', attr: '', pattern: '', replacement: '', required: true},
                           {partition: partition, type: 'Text', name: 'Value Name', key: 'name', value: '',
                            element: '.brand', attr: '', pattern: '', replacement: '', required: false},
                           {partition: partition, type: 'Text', name: 'Value New Price', key: 'new_price', value: '',
                            element: '.price.special', attr: '', pattern: '\D', replacement: '', required: true},
                           {partition: partition, type: 'AttributeValue', name: 'Value Discount', key: 'discount', value: '',
                            element: '.labelBig', attr: 'class', pattern: '\D', replacement: '', required: false},
                           {partition: partition, type: 'Text', name: 'Value Old Price', key: 'old_price', value: '',
                            element: '.price.old',
                            attr: '', pattern: '\D', replacement: '', required: true},
                           {partition: partition, type: 'Attachment', name: 'Value Thumb', key: 'thumb', value: '',
                            element: '.highslide', attr: 'href', pattern: '', replacement: '', required: true}]

      end
    end
  end

  def down
    Scraper.where(name: 'Butik').each do |s|
      s.delete
    end
    Partner.where(name: 'Butik').each do |p|
      p.delete
    end
  end
end
