AnkaaStatistic::Engine.load_seed
AnkaaContent::Engine.load_seed

VirtualContextType.find_or_create_by! name: 'Application'
VirtualContextType.find_or_create_by! name: 'Button'

#Lamoda
lamoda_scraper = Scraper.find_or_create_by! name: 'Lamoda' do |scraper|
  scraper.update_attributes! scope: '', selector: 'a.products-list-item__link',
                             condition: 'span.product-label:not(.product-label_new)', element: '', attr: 'href',
                             source_pattern: '(.+)', source_replacement: 'http://www.lamoda.ru\1',
                             url_prefix: 'http://f.gdeslon.ru/f/2352c31c3271d918f7f00179c58215f5a3d231d6?goto=', url_postfix: ''
  Partition.create! name: 'Lamoda Body', scope: 'body', source: scraper, order: 1 do |lamoda_partition|
    Extractor.create! [{partition: lamoda_partition, type: 'Text', name: 'Value Name', key: 'name',
                        element: 'a.product-card__header-link', attr: '', pattern: '', replacement: '', required: false},
                       {partition: lamoda_partition, type: 'Text', name: 'Value New Price', key: 'new_price',
                        element: '.product-card__price span.price__new', attr: '', pattern: '\D', replacement: '', required: true},
                       {partition: lamoda_partition, type: 'Text', name: 'Value Discount', key: 'discount',
                        element: 'span.product-label', attr: '', pattern: '\D', replacement: '', required: false},
                       {partition: lamoda_partition, type: 'Text', name: 'Value Old Price', key: 'old_price',
                        element: '.product-card__price span.price__old',
                        attr: '', pattern: '\D', replacement: '', required: true},
                       {partition: lamoda_partition, type: 'Attachment', name: 'Value Thumb', key: 'thumb',
                        element: 'li.photos-list__item:not([data-type="3d"]):nth-child(1)',
                        attr: 'data-orig', pattern: '^(.+)img\d+x\d+(.+)$', replacement: 'http:\1product\2', required: true}]

    Extractor.create! partition: lamoda_partition, type: 'HasMany', name: 'Value Descriptions', key: 'descriptions_attributes',
                      element: '', attr: '', pattern: '', replacement: '', order: true, source: true, required: false do |extractor|
      Partition.create! name: 'Description Header', scope: 'div.product-content__sheet', source: extractor, order: 1 do |description_partition|
        Extractor.create! partition: description_partition, type: 'Text', name: 'Description Text', key: 'text',
                          element: 'p.product-content__p', attr: '', pattern: '', replacement: '', required: false

      end
      Partition.create! name: 'Description Table', scope: 'table.product-content__table tr', source: extractor, order: 2 do |description_partition|
        Extractor.create! [{partition: description_partition, type: 'Text', name: 'Description Caption', key: 'caption',
                            element: 'th', attr: '', pattern: '', replacement: '', required: false},
                           {partition: description_partition, type: 'Text', name: 'Description Text', key: 'text',
                            element: 'td', attr: '', pattern: '', replacement: '', required: false}]

      end
    end
    Extractor.create! partition: lamoda_partition, type: 'HasMany', name: 'Value Promos', key: 'promos_attributes',
                      element: '', attr: '', pattern: '', replacement: '', order: true, source: false, required: false do |extractor|
      Partition.create! name: 'Image Slider', scope: 'ul.photos-list__list li:not([data-type="3d"])', source: extractor, order: 1 do |promo_partition|
        Extractor.create! [{partition: promo_partition, type: 'Attachment', name: 'Promo Image', key: 'image',
                            element: '', attr: 'data-orig', pattern: '^(.+)img\d+x\d+(.+)$', replacement: 'http:\1product\2', required: false},
                           {partition: promo_partition, type: 'AttributeValue', name: 'Promo Source', key: 'source',
                            element: '', attr: 'data-orig', pattern: '^(.+)img\d+x\d+(.+)$', replacement: 'http:\1product\2', required: false}]

      end
    end
  end
end

#Wildberries
wildberries_scraper = Scraper.find_or_create_by! name: 'Wildberries' do |scraper|
  scraper.update_attributes! scope: '', selector: 'div.dtList', condition: 'span.proc_div',
                             element: 'a.ref_goods_n_p', attr: 'href', source_pattern: '', source_replacement: '',
                             url_prefix: 'http://f.gdeslon.ru/f/c81c6bb247231b0cb907d1dd6fd5eef167444c3f?goto=', url_postfix: ''
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

#Quelle
Scraper.find_or_create_by! name: 'Quelle' do |scraper|
  scraper.update_attributes! scope: 'ol.productsBox', selector: 'div.productBox', condition: 'div.productStreichpreis',
                             element: 'div.productQuickLookBox > a', attr: 'href', source_pattern: '([\w:\/\.-]+)', source_replacement: '\1',
                             url_prefix: '', url_postfix: ''
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


TopicGroup.find_or_create_by! key: 'da46a5a8de1577cecf9baed38d4fe65c' do |topic_group|
  topic_group.update_attributes! order: 1, name: 'Женщинам', active: true

  Topic.create! topic_group: topic_group, order: 1, name: 'Женская Обувь', displayed_name: 'Обувь',
                active: true do |topic|

    Category.create! topic: topic, order: 1, name: 'Женские Сапоги', displayed_name: 'Сапоги',
                     active: true do |category|
      Miner.create! category: category do |miner|
        MinerScraper.create!([
                                 {miner: miner, scraper: lamoda_scraper,
                                  url_prefix: 'http://www.lamoda.ru/c/21/shoes-sapogi/?genders=women&page=',
                                  url_postfix: '', limit: 10},
                                 {miner: miner, scraper: wildberries_scraper,
                                  url_prefix: 'http://www.wildberries.ru/catalog/89/',
                                  url_postfix: '/women.aspx', limit: 10},
                             ])
      end
    end

    Category.create! topic: topic, order: 2, name: 'Женские Туфли', displayed_name: 'Туфли',
                     active: true do |category|
      Miner.create! category: category do |miner|
        MinerScraper.create!([
                                 {miner: miner, scraper: lamoda_scraper,
                                  url_prefix: 'http://www.lamoda.ru/c/33/shoes-tufli/?genders=women&page=',
                                  url_postfix: '', limit: 10},
                                 {miner: miner, scraper: wildberries_scraper,
                                  url_prefix: 'http://www.wildberries.ru/catalog/313/',
                                  url_postfix: '/women.aspx', limit: 10},
                             ])
      end
    end

    Category.create! topic: topic, order: 3, name: 'Женские Ботинки', displayed_name: 'Ботинки',
                     active: true do |category|
      Miner.create! category: category do |miner|
        MinerScraper.create!([
                                 {miner: miner, scraper: lamoda_scraper,
                                  url_prefix: 'http://www.lamoda.ru/c/23/shoes-botinki/?genders=women&page=',
                                  url_postfix: '', limit: 10},
                                 {miner: miner, scraper: wildberries_scraper,
                                  url_prefix: 'http://www.wildberries.ru/catalog/352/',
                                  url_postfix: '/women.aspx', limit: 10},
                             ])
      end
    end

    Category.create! topic: topic, order: 4, name: 'Женские Кроссовки', displayed_name: 'Кроссовки',
                     active: true do |category|
      Miner.create! category: category do |miner|
        MinerScraper.create!([
                                 {miner: miner, scraper: lamoda_scraper,
                                  url_prefix: 'http://www.lamoda.ru/c/2968/shoes-krossovki-kedy/?genders=women&page=',
                                  url_postfix: '', limit: 10},
                                 {miner: miner, scraper: wildberries_scraper,
                                  url_prefix: 'http://www.wildberries.ru/catalog/92/',
                                  url_postfix: '/women.aspx', limit: 10},
                             ])
      end
    end

    Category.create! topic: topic, order: 5, name: 'Женские Сандалии', displayed_name: 'Сандалии',
                     active: true do |category|
      Miner.create! category: category do |miner|
        MinerScraper.create!([
                                 {miner: miner, scraper: lamoda_scraper,
                                  url_prefix: 'http://www.lamoda.ru/c/127/shoes-sandalii/?genders=women&page=',
                                  url_postfix: '', limit: 10},
                                 {miner: miner, scraper: wildberries_scraper,
                                  url_prefix: 'http://www.wildberries.ru/catalog/314/',
                                  url_postfix: '/women.aspx', limit: 10},
                             ])
      end
    end

  end

  Topic.create! topic_group: topic_group, order: 2, name: 'Женская Одежда', displayed_name: 'Одежда',
                active: true do |topic|
    Category.create! topic: topic, order: 1, name: 'Женская Верхняя Одежда', displayed_name: 'Верхняя Одежда',
                     active: true do |category|
      Miner.create! category: category do |miner|
        MinerScraper.create!([
                                 {miner: miner, scraper: lamoda_scraper,
                                  url_prefix: 'http://www.lamoda.ru/c/357/clothes-verkhnyaya-odezhda/?genders=women&page=',
                                  url_postfix: '', limit: 10},
                                 {miner: miner, scraper: wildberries_scraper,
                                  url_prefix: 'http://www.wildberries.ru/catalog/1395/',
                                  url_postfix: '/women.aspx', limit: 10},
                             ])
      end
    end

    Category.create! topic: topic, order: 2, name: 'Женские Платья', displayed_name: 'Платья',
                     active: true do |category|
      Miner.create! category: category do |miner|
        MinerScraper.create!([
                                 {miner: miner, scraper: lamoda_scraper,
                                  url_prefix: 'http://www.lamoda.ru/c/369/clothes-platiya/?genders=women&page=',
                                  url_postfix: '', limit: 10},
                                 {miner: miner, scraper: wildberries_scraper,
                                  url_prefix: 'http://www.wildberries.ru/catalog/20/',
                                  url_postfix: '/women.aspx', limit: 10},
                             ])
      end
    end

    Category.create! topic: topic, order: 3, name: 'Женские Юбки', displayed_name: 'Юбки',
                     active: true do |category|
      Miner.create! category: category do |miner|
        MinerScraper.create!([
                                 {miner: miner, scraper: lamoda_scraper,
                                  url_prefix: 'http://www.lamoda.ru/c/423/clothes-yubki/?genders=women&page=',
                                  url_postfix: '', limit: 10},
                                 {miner: miner, scraper: wildberries_scraper,
                                  url_prefix: 'http://www.wildberries.ru/catalog/19/',
                                  url_postfix: '/women.aspx', limit: 10},
                             ])
      end
    end

    Category.create! topic: topic, order: 4, name: 'Женские Джемперы', displayed_name: 'Джемперы',
                     active: true do |category|
      Miner.create! category: category do |miner|
        MinerScraper.create!([
                                 {miner: miner, scraper: lamoda_scraper,
                                  url_prefix: 'http://www.lamoda.ru/c/371/clothes-trikotazh/?genders=women&page=',
                                  url_postfix: '', limit: 10},
                                 {miner: miner, scraper: wildberries_scraper,
                                  url_prefix: 'http://www.wildberries.ru/catalog/302/',
                                  url_postfix: '/women.aspx', limit: 10},
                             ])
      end
    end

    Category.create! topic: topic, order: 5, name: 'Женские Толстовки', displayed_name: 'Толстовки',
                     active: true do |category|
      Miner.create! category: category do |miner|
        MinerScraper.create!([
                                 {miner: miner, scraper: lamoda_scraper,
                                  url_prefix: 'http://www.lamoda.ru/c/2474/clothes-tolstovki-olimpiyki/?genders=women&page=',
                                  url_postfix: '', limit: 10},
                                 {miner: miner, scraper: wildberries_scraper,
                                  url_prefix: 'http://www.wildberries.ru/catalog/304/',
                                  url_postfix: '/women.aspx', limit: 10},
                             ])
      end
    end

    Category.create! topic: topic, order: 6, name: 'Женские Топы и Майки', displayed_name: 'Топы и Майки',
                     active: true do |category|
      Miner.create! category: category do |miner|
        MinerScraper.create!([
                                 {miner: miner, scraper: lamoda_scraper,
                                  url_prefix: 'http://www.lamoda.ru/c/2627/clothes-topy/?genders=women&page=',
                                  url_postfix: '', limit: 10},
                                 {miner: miner, scraper: wildberries_scraper,
                                  url_prefix: 'http://www.wildberries.ru/catalog/14/',
                                  url_postfix: '/women.aspx', limit: 10},
                             ])
      end
    end

  end

end

TopicGroup.find_or_create_by! key: '009980d31a1931b2f6b363d8fdd36bba' do |topic_group|
  topic_group.update_attributes! order: 2, name: 'Мужчинам', active: false
end

TopicGroup.find_or_create_by! key: '644827f93d7d92ccf25cf56fd63f3d42' do |topic_group|
  topic_group.update_attributes! order: 3, name: 'Детям', active: false
end
