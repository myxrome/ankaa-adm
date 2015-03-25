class QuelleScraper < SeedMigration::Migration
  def up

    quelle = Partner.find_or_create_by!(name: 'Quelle') do |partner|
      partner.update_attributes! url: 'http://www.quelle.ru/', active: true
    end

    Scraper.find_or_create_by! name: 'Quelle' do |scraper|
      scraper.update_attributes! scope: 'ol.productsBox', selector: 'div.productBox', condition: 'div.productStreichpreis',
                                 element: 'div.productQuickLookBox > a', attr: 'href', source_pattern: '([\w:\/\.-]+)', source_replacement: '\1',
                                 url_prefix: '', url_postfix: '', active: false
      Partition.create! name: 'Quelle Body', scope: 'body', source: scraper, order: 1 do |ql_partition|
        Extractor.create! [{partition: ql_partition, type: 'ConstantValue', name: 'Partner', key: 'partner_id', value: quelle.id,
                            element: '', attr: '', pattern: '', replacement: '', required: true},
                           {partition: ql_partition, type: 'Text', name: 'Value Name', key: 'name', value: '',
                            element: 'h1.h2', attr: '',
                            pattern: '([^\.]+)', replacement: '\1', required: false},
                           {partition: ql_partition, type: 'Text', name: 'Value New Price', key: 'new_price', value: '',
                            element: '.productPrice', attr: '', pattern: '\D', replacement: '', required: true},
                           {partition: ql_partition, type: 'Text', name: 'Value Discount', key: 'discount', value: '',
                            element: '.productPriceSlogan > strong:nth-child(1)', attr: '', pattern: '\D', replacement: '', required: false},
                           {partition: ql_partition, type: 'Text', name: 'Value Old Price', key: 'old_price', value: '',
                            element: '#productDetailProductPriceBox > div:nth-child(2)',
                            attr: '', pattern: '\D', replacement: '', required: true},
                           {partition: ql_partition, type: 'Attachment', name: 'Value Thumb', key: 'thumb', value: '',
                            element: 'a._copy_layer_contents_to_element:nth-child(1)',
                            attr: 'href', pattern: '([\w:\/\.-]+)', replacement: 'http:\1', required: true}]

        Extractor.create! partition: ql_partition, type: 'HasMany', name: 'Value Descriptions', key: 'descriptions_attributes', value: '',
                          element: '', attr: '', pattern: '', replacement: '', order: true, source: true, required: false do |extractor|
          Partition.create! name: 'Description Header', scope: '.productLangtextBox', source: extractor, order: 1 do |description_partition|
            Extractor.create! partition: description_partition, type: 'Text', name: 'Description Text', key: 'text', value: '',
                              element: 'span:nth-child(2) > p:nth-child(1)', attr: '', pattern: '', replacement: '', required: false

          end
        end

        Extractor.create! partition: ql_partition, type: 'HasMany', name: 'Value Promos', key: 'promos_attributes', value: '',
                          element: '', attr: '', pattern: '', replacement: '', order: true, source: false, required: false do |extractor|
          Partition.create! name: 'Image Slider', scope: '.verticalImageListBox > ul:nth-child(1) > li', source: extractor, order: 1 do |promo_partition|
            Extractor.create! [{partition: promo_partition, type: 'Attachment', name: 'Promo Image', key: 'image', value: '',
                                element: 'a._copy_layer_contents_to_element', attr: 'href', pattern: '([\w:\/\.-]+)', replacement: 'http:\1', required: false},
                               {partition: promo_partition, type: 'AttributeValue', name: 'Promo Source', key: 'source', value: '',
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
    Partner.where(name: 'Quelle').each do |p|
      p.delete
    end
  end
end
