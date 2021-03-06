class LamodaScraper < SeedMigration::Migration
  def up
    lamoda = Partner.find_or_create_by! name: 'Lamoda' do |partner|
      partner.update_attributes! url: 'http://www.lamoda.ru/', active: true
    end

    Scraper.find_or_create_by! name: 'Lamoda' do |scraper|
      scraper.update_attributes! scope: '', selector: 'a.products-list-item__link',
                                 condition: 'span.product-label:not(.product-label_new)', element: '', attr: 'href',
                                 source_pattern: '(.+)', source_replacement: 'http://www.lamoda.ru\1',
                                 url_prefix: 'http://f.gdeslon.ru/f/2352c31c3271d918f7f00179c58215f5a3d231d6?goto=', url_postfix: '', active: true
      Partition.create! name: 'Lamoda Body', scope: 'body', source: scraper, order: 1 do |partition|
        Extractor.create! [{partition: partition, type: 'ConstantValue', name: 'Partner', key: 'partner_id', value: lamoda.id,
                            element: '', attr: '', pattern: '', replacement: '', required: true},
                           {partition: partition, type: 'Text', name: 'Value Name', key: 'name', value: '',
                            element: 'a.product-card__header-link', attr: '', pattern: '', replacement: '', required: false},
                           {partition: partition, type: 'Text', name: 'Value New Price', key: 'new_price', value: '',
                            element: '.product-card__price span.price__new', attr: '', pattern: '\D', replacement: '', required: true},
                           {partition: partition, type: 'Text', name: 'Value Discount', key: 'discount', value: '',
                            element: 'span.product-label', attr: '', pattern: '\D', replacement: '', required: false},
                           {partition: partition, type: 'Text', name: 'Value Old Price', key: 'old_price', value: '',
                            element: '.product-card__price span.price__old',
                            attr: '', pattern: '\D', replacement: '', required: true},
                           {partition: partition, type: 'Attachment', name: 'Value Thumb', key: 'thumb', value: '',
                            element: 'li.photos-list__item[data-type="zoom"]:nth-of-type(1)',
                            attr: 'data-orig', pattern: '^(.+)img\d+x\d+(.+)$', replacement: 'http:\1product\2', required: true}]

        # Extractor.create! partition: lamoda_partition, type: 'HasMany', name: 'Value Descriptions', key: 'descriptions_attributes', value: '',
        #                   element: '', attr: '', pattern: '', replacement: '', order: true, source: true, required: false do |extractor|
        #   Partition.create! name: 'Description Header', scope: 'div.product-content__sheet', source: extractor, order: 1 do |description_partition|
        #     Extractor.create! partition: description_partition, type: 'Text', name: 'Description Text', key: 'text', value: '',
        #                       element: 'p.product-content__p', attr: '', pattern: '', replacement: '', required: false
        #
        #   end
        #   Partition.create! name: 'Description Table', scope: 'table.product-content__table tr', source: extractor, order: 2 do |description_partition|
        #     Extractor.create! [{partition: description_partition, type: 'Text', name: 'Description Caption', key: 'caption', value: '',
        #                         element: 'th', attr: '', pattern: '', replacement: '', required: false},
        #                        {partition: description_partition, type: 'Text', name: 'Description Text', key: 'text', value: '',
        #                         element: 'td', attr: '', pattern: '', replacement: '', required: false}]
        #
        #   end
        # end
        # Extractor.create! partition: lamoda_partition, type: 'HasMany', name: 'Value Promos', key: 'promos_attributes', value: '',
        #                   element: '', attr: '', pattern: '', replacement: '', order: true, source: false, required: false do |extractor|
        #   Partition.create! name: 'Image Slider', scope: 'ul.photos-list__list li[data-type="zoom"]', source: extractor, order: 1 do |promo_partition|
        #     Extractor.create! [{partition: promo_partition, type: 'Attachment', name: 'Promo Image', key: 'image', value: '',
        #                         element: '', attr: 'data-orig', pattern: '^(.+)img\d+x\d+(.+)$', replacement: 'http:\1product\2', required: false},
        #                        {partition: promo_partition, type: 'AttributeValue', name: 'Promo Source', key: 'source', value: '',
        #                         element: '', attr: 'data-orig', pattern: '^(.+)img\d+x\d+(.+)$', replacement: 'http:\1product\2', required: false}]
        #
        #   end
        # end
      end
    end
  end

  def down
    Scraper.where(name: 'Lamoda').each do |s|
      s.delete
    end
    Partner.where(name: 'Lamoda').each do |p|
      p.delete
    end
  end
end
