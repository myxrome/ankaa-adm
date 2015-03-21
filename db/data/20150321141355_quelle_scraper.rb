class QuelleScraper < SeedMigration::Migration
  def up
    Scraper.find_or_create_by! name: 'Quelle' do |scraper|
      scraper.update_attributes! scope: 'ol.productsBox', selector: 'div.productBox', condition: 'div.productStreichpreis',
                                 element: 'div.productQuickLookBox > a', attr: 'href', source_pattern: '([\w:\/\.-]+)', source_replacement: '\1',
                                 url_prefix: '', url_postfix: '', active: false
      Partition.create! name: 'Quelle Body', scope: 'body', source: scraper, order: 1 do |ql_partition|
        Extractor.create! [{partition: ql_partition, type: 'Text', name: 'Value Name', key: 'name',
                            element: 'h1.h2', attr: '',
                            pattern: '([^\.]+)', replacement: '\1', required: false},
                           {partition: ql_partition, type: 'Text', name: 'Value New Price', key: 'new_price',
                            element: '.productPrice', attr: '', pattern: '\D', replacement: '', required: true},
                           {partition: ql_partition, type: 'Text', name: 'Value Discount', key: 'discount',
                            element: '.productPriceSlogan > strong:nth-child(1)', attr: '', pattern: '\D', replacement: '', required: false},
                           {partition: ql_partition, type: 'Text', name: 'Value Old Price', key: 'old_price',
                            element: '#productDetailProductPriceBox > div:nth-child(2)',
                            attr: '', pattern: '\D', replacement: '', required: true},
                           {partition: ql_partition, type: 'Attachment', name: 'Value Thumb', key: 'thumb',
                            element: 'a._copy_layer_contents_to_element:nth-child(1)',
                            attr: 'href', pattern: '([\w:\/\.-]+)', replacement: 'http:\1', required: true}]

        Extractor.create! partition: ql_partition, type: 'HasMany', name: 'Value Descriptions', key: 'descriptions_attributes',
                          element: '', attr: '', pattern: '', replacement: '', order: true, source: true, required: false do |extractor|
          Partition.create! name: 'Description Header', scope: '.productLangtextBox', source: extractor, order: 1 do |description_partition|
            Extractor.create! partition: description_partition, type: 'Text', name: 'Description Text', key: 'text',
                              element: 'span:nth-child(2) > p:nth-child(1)', attr: '', pattern: '', replacement: '', required: false

          end
        end

        Extractor.create! partition: ql_partition, type: 'HasMany', name: 'Value Promos', key: 'promos_attributes',
                          element: '', attr: '', pattern: '', replacement: '', order: true, source: false, required: false do |extractor|
          Partition.create! name: 'Image Slider', scope: '.verticalImageListBox > ul:nth-child(1) > li', source: extractor, order: 1 do |promo_partition|
            Extractor.create! [{partition: promo_partition, type: 'Attachment', name: 'Promo Image', key: 'image',
                                element: 'a._copy_layer_contents_to_element', attr: 'href', pattern: '([\w:\/\.-]+)', replacement: 'http:\1', required: false},
                               {partition: promo_partition, type: 'AttributeValue', name: 'Promo Source', key: 'source',
                                element: 'a._copy_layer_contents_to_element', attr: 'href', pattern: '([\w:\/\.-]+)', replacement: 'http:\1', required: false}]

          end
        end
      end
    end
  end

  def down
    Scraper.where(name: 'Quelle').each do |s|
      s.delete
    end
  end
end
