class WildberriesScraper < SeedMigration::Migration
  def up
    Scraper.find_or_create_by! name: 'Wildberries' do |scraper|
      scraper.update_attributes! scope: '', selector: 'div.dtList', condition: 'span.proc_div',
                                 element: 'a.ref_goods_n_p', attr: 'href', source_pattern: '', source_replacement: '',
                                 url_prefix: 'http://f.gdeslon.ru/f/c81c6bb247231b0cb907d1dd6fd5eef167444c3f?goto=', url_postfix: '', active: false
      Partition.create! name: 'Wildberries Body', scope: 'body', source: scraper, order: 1 do |wb_partition|
        Extractor.create! [{partition: wb_partition, type: 'Text', name: 'Value Name', key: 'name',
                            element: 'h1[itemprop="name"]', attr: '',
                            pattern: '', replacement: '', required: false},
                           {partition: wb_partition, type: 'Text', name: 'Value New Price', key: 'new_price',
                            element: '#Price > ins[itemprop="price"]', attr: '', pattern: '\D', replacement: '', required: true},
                           {partition: wb_partition, type: 'Text', name: 'Value Discount', key: 'discount',
                            element: '.discount', attr: '', pattern: '\D', replacement: '', required: false},
                           {partition: wb_partition, type: 'Text', name: 'Value Old Price', key: 'old_price',
                            element: '#Price > del',
                            attr: '', pattern: '\D', replacement: '', required: true},
                           {partition: wb_partition, type: 'Attachment', name: 'Value Thumb', key: 'thumb',
                            element: 'ul.carousel a.enabledZoom:nth-child(1)',
                            attr: 'href', pattern: '(.+)', replacement: 'http:\1', required: true}]

        Extractor.create! partition: wb_partition, type: 'HasMany', name: 'Value Descriptions', key: 'descriptions_attributes',
                          element: '', attr: '', pattern: '', replacement: '', order: true, source: true, required: false do |extractor|
          Partition.create! name: 'Description Header', scope: '#description', source: extractor, order: 1 do |description_partition|
            Extractor.create! partition: description_partition, type: 'Text', name: 'Description Text', key: 'text',
                              element: '', attr: '', pattern: '', replacement: '', required: false

          end
          Partition.create! name: 'Description Table 1', scope: 'p.pp', source: extractor, order: 2 do |description_partition|
            Extractor.create! [{partition: description_partition, type: 'Text', name: 'Description Caption', key: 'caption',
                                element: 'text()', attr: '', pattern: '', replacement: '', required: false},
                               {partition: description_partition, type: 'Text', name: 'Description Text', key: 'text',
                                element: 'span', attr: '', pattern: '', replacement: '', required: false}]
          end
          Partition.create! name: 'Description Table 2', scope: 'table.pp-additional tr', source: extractor, order: 3 do |description_partition|
            Extractor.create! [{partition: description_partition, type: 'Text', name: 'Description Caption', key: 'caption',
                                element: 'td:nth-child(1)', attr: '', pattern: '(.+)', replacement: '\1:', required: false},
                               {partition: description_partition, type: 'Text', name: 'Description Text', key: 'text',
                                element: 'td:nth-child(2)', attr: '', pattern: '', replacement: '', required: false}]

          end
        end
        Extractor.create! partition: wb_partition, type: 'HasMany', name: 'Value Promos', key: 'promos_attributes',
                          element: '', attr: '', pattern: '', replacement: '', order: true, source: false, required: false do |extractor|
          Partition.create! name: 'Image Slider', scope: 'ul.carousel a.enabledZoom', source: extractor, order: 1 do |promo_partition|
            Extractor.create! [{partition: promo_partition, type: 'Attachment', name: 'Promo Image', key: 'image',
                                element: '', attr: 'href', pattern: '(.+)', replacement: 'http:\1', required: false},
                               {partition: promo_partition, type: 'AttributeValue', name: 'Promo Source', key: 'source',
                                element: '', attr: 'href', pattern: '(.+)', replacement: 'http:\1', required: false}]

          end
        end
      end
    end
  end

  def down
    Scraper.where(name: 'Wildberries').each do |s|
      s.delete
    end
  end
end