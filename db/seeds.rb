# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
VirtualContextType.create! [{name: 'Application'}, {name: 'Button'}]

#Lamoda
Scraper.create! name: 'Lamoda', scope: '', selector: 'a.products-list-item__link',
                condition: 'span.product-label:not(.product-label_new)', element: '', attr: 'href',
                prefix: 'http://www.lamoda.ru', postfix: '', source: true do |scraper|
  Mapping.create! name: 'Lamoda Body', scope: 'body', source: scraper do |lamoda_mapping|
    Transformer.create! [{mapping: lamoda_mapping, type: 'Text', name: 'Value Name', key: 'name',
                        element: 'a.product-card__header-link', attr: '', substring: '', prefix: '', postfix: ''},
                        {mapping: lamoda_mapping, type: 'Text', name: 'Value New Price', key: 'new_price',
                        element: 'span.price__new:nth-child(3)', attr: '', substring: '', prefix: '', postfix: ''},
                        {mapping: lamoda_mapping, type: 'Text', name: 'Value Discount', key: 'discount',
                        element: 'span.product-label', attr: '', substring: '', prefix: '', postfix: ''},
                        {mapping: lamoda_mapping, type: 'Text', name: 'Value Old Price', key: 'old_price',
                        element: 'span.price:nth-child(1) > span:nth-child(1)',
                        attr: '', substring: '', prefix: '', postfix: ''}]

    Transformer.create! mapping: lamoda_mapping, type: 'HasMany', name: 'Value Descriptions', key: 'descriptions_attributes',
                        element: '', attr: '', substring: '', prefix: '', postfix: '', order: true, source: true do |transformer|
      Mapping.create! name: 'Description Header', scope: 'div.product-content__sheet', source: transformer do |description_mapping|
        Transformer.create! mapping: description_mapping, type: 'Text', name: 'Description Text', key: 'text',
                            element: 'p.product-content__p', attr: '', substring: '', prefix: '', postfix: ''

      end
      Mapping.create! name: 'Description Table', scope: 'table.product-content__table tr', source: transformer do |description_mapping|
        Transformer.create! [{mapping: description_mapping, type: 'Text', name: 'Description Caption', key: 'caption',
                            element: 'th', attr: '', substring: '', prefix: '', postfix: ''},
                            {mapping: description_mapping, type: 'Text', name: 'Description Text', key: 'text',
                            element: 'td', attr: '', substring: '', prefix: '', postfix: ''}]

      end
    end
    Transformer.create! mapping: lamoda_mapping, type: 'HasMany', name: 'Value Promos', key: 'promos_attributes',
                        element: '', attr: '', substring: '', prefix: '', postfix: '', order: true, source: false do |transformer|
      Mapping.create! name: 'Description Table', scope: 'table.product-content__table tr', source: transformer do |promo_mapping|
        Transformer.create! [{mapping: promo_mapping, type: 'Attachment', name: 'Promo Image', key: 'image',
                            element: '', attr: 'data-orig', substring: '', prefix: 'http:', postfix: ''},
                            {mapping: promo_mapping, type: 'AttributeValue', name: 'Promo Source', key: 'source',
                            element: '', attr: 'data-orig', substring: '', prefix: 'http:', postfix: ''}]

      end
    end
  end
end

#Wildberries
Scraper.create! name: 'Wildberries', scope: '', selector: 'div.dtList',
                condition: 'span.proc_div', element: 'a.ref_goods_n_p', attr: 'href',
                prefix: '', postfix: '', source: true do |scraper|
  Mapping.create! name: 'Wildberries Body', scope: 'body', source: scraper do |wb_mapping|
    Transformer.create! [{mapping: wb_mapping, type: 'Text', name: 'Value Name', key: 'name',
                          element: 'div.div:nth-child(1) > div:nth-child(1) > h1:nth-child(1)', attr: '',
                          substring: '', prefix: '', postfix: ''},
                         {mapping: wb_mapping, type: 'Text', name: 'Value New Price', key: 'new_price',
                          element: '#Price > ins:nth-child(1)', attr: '', substring: '', prefix: '', postfix: ''},
                         {mapping: wb_mapping, type: 'Text', name: 'Value Discount', key: 'discount',
                          element: '.discount', attr: '', substring: '[−\d%]+', prefix: '', postfix: ''},
                         {mapping: wb_mapping, type: 'Text', name: 'Value Old Price', key: 'old_price',
                          element: '#Price > del:nth-child(2)',
                          attr: '', substring: '', prefix: '', postfix: ''}]

    Transformer.create! mapping: wb_mapping, type: 'HasMany', name: 'Value Descriptions', key: 'descriptions_attributes',
                        element: '', attr: '', substring: '', prefix: '', postfix: '', order: true, source: true do |transformer|
      Mapping.create! name: 'Description Header', scope: '#description', source: transformer do |description_mapping|
        Transformer.create! mapping: description_mapping, type: 'Text', name: 'Description Text', key: 'text',
                            element: '', attr: '', substring: '', prefix: '', postfix: ''

      end
      Mapping.create! name: 'Description Table 1', scope: 'p.pp', source: transformer do |description_mapping|
        Transformer.create! [{mapping: description_mapping, type: 'Text', name: 'Description Caption', key: 'caption',
                              element: 'text()', attr: '', substring: '', prefix: '', postfix: ''},
                             {mapping: description_mapping, type: 'Text', name: 'Description Text', key: 'text',
                              element: 'span', attr: '', substring: '', prefix: '', postfix: ''}]
      end
      Mapping.create! name: 'Description Table 2', scope: 'table.pp-additional tr', source: transformer do |description_mapping|
        Transformer.create! [{mapping: description_mapping, type: 'Text', name: 'Description Caption', key: 'caption',
                              element: 'td:nth-child(1)', attr: '', substring: '', prefix: '', postfix: ':'},
                             {mapping: description_mapping, type: 'Text', name: 'Description Text', key: 'text',
                              element: 'td:nth-child(2)', attr: '', substring: '', prefix: '', postfix: ''}]

      end
    end
    Transformer.create! mapping: wb_mapping, type: 'HasMany', name: 'Value Promos', key: 'promos_attributes',
                        element: '', attr: '', substring: '', prefix: '', postfix: '', order: true, source: false do |transformer|
      Mapping.create! name: 'Description Table', scope: 'ul.carousel a.enabledZoom', source: transformer do |promo_mapping|
        Transformer.create! [{mapping: promo_mapping, type: 'Attachment', name: 'Promo Image', key: 'image',
                              element: '', attr: 'href', substring: '', prefix: 'http:', postfix: ''},
                             {mapping: promo_mapping, type: 'AttributeValue', name: 'Promo Source', key: 'source',
                              element: '', attr: 'href', substring: '', prefix: 'http:', postfix: ''}]

      end
    end
  end
end

#Quelle
Scraper.create! name: 'Quelle', scope: 'ol.productsBox', selector: 'div.productImageBox',
                condition: 'div.produktBildAuflegerReduziert', element: 'a', attr: 'href',
                prefix: '', postfix: '', source: true do |scraper|
  Mapping.create! name: 'Quelle Body', scope: 'body', source: scraper do |wb_mapping|
    Transformer.create! [{mapping: wb_mapping, type: 'Text', name: 'Value Name', key: 'name',
                          element: ' 	h1.h2', attr: '',
                          substring: '', prefix: '', postfix: ''},
                         {mapping: wb_mapping, type: 'Text', name: 'Value New Price', key: 'new_price',
                          element: '.default', attr: '', substring: '\d+', prefix: '', postfix: ' руб.'},
                         {mapping: wb_mapping, type: 'Text', name: 'Value Discount', key: 'discount',
                          element: '.productPriceSlogan > strong:nth-child(1)', attr: '', substring: '', prefix: '-', postfix: '%'},
                         {mapping: wb_mapping, type: 'Text', name: 'Value Old Price', key: 'old_price',
                          element: ' 	#productDetailProductPriceBox > div:nth-child(2)',
                          attr: '', substring: '\d+', prefix: '', postfix: ' руб.'}]

    Transformer.create! mapping: wb_mapping, type: 'HasMany', name: 'Value Descriptions', key: 'descriptions_attributes',
                        element: '', attr: '', substring: '', prefix: '', postfix: '', order: true, source: true do |transformer|
      Mapping.create! name: 'Description Header', scope: '.productLangtextBox', source: transformer do |description_mapping|
        Transformer.create! mapping: description_mapping, type: 'Text', name: 'Description Text', key: 'text',
                            element: 'span:nth-child(2) > p:nth-child(1)', attr: '', substring: '', prefix: '', postfix: ''

      end
    end

    Transformer.create! mapping: wb_mapping, type: 'HasMany', name: 'Value Promos', key: 'promos_attributes',
                        element: '', attr: '', substring: '', prefix: '', postfix: '', order: true, source: false do |transformer|
      Mapping.create! name: 'Description Table', scope: '.verticalImageListBox > ul:nth-child(1) > li', source: transformer do |promo_mapping|
        Transformer.create! [{mapping: promo_mapping, type: 'Attachment', name: 'Promo Image', key: 'image',
                              element: 'a._copy_layer_contents_to_element', attr: 'href', substring: '', prefix: 'http:', postfix: ''},
                             {mapping: promo_mapping, type: 'AttributeValue', name: 'Promo Source', key: 'source',
                              element: 'a._copy_layer_contents_to_element', attr: 'href', substring: '', prefix: 'http:', postfix: ''}]

      end
    end
  end
end
