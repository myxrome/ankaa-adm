# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
VirtualContextType.create! name: 'Application'
VirtualContextType.create! name: 'Button'

#Lamoda
lamoda_scraper = Scraper.create! name: 'Lamoda', element: 'a.products-list-item__link',
                                 attr: 'href', condition: 'span.product-label:not(.product-label_new)',
                                 prefix: 'http://www.lamoda.ru', postfix: '', paginator: '&page=',
                                 source_key: 'source'
lamoda_body_mapping = Mapping.create! name: 'Lamoda Body', scope: 'body', source: lamoda_scraper
Transformer.create! mapping: lamoda_body_mapping, type: 'Text', name: 'Value Name', key: 'name',
                    order_key: '', source_key: '', element: 'a.product-card__header-link',
                    attr: '', prefix: '', postfix: ''
Transformer.create! mapping: lamoda_body_mapping, type: 'Text', name: 'Value New Price', key: 'new_price',
                    order_key: '', source_key: '', element: 'span.price__new:nth-child(3)',
                    attr: '', prefix: '', postfix: ''
Transformer.create! mapping: lamoda_body_mapping, type: 'Text', name: 'Value Discount', key: 'discount',
                    order_key: '', source_key: '', element: 'span.product-label',
                    attr: '', prefix: '', postfix: ''
Transformer.create! mapping: lamoda_body_mapping, type: 'Text', name: 'Value Old Price', key: 'old_price',
                    order_key: '', source_key: '', element: 'span.price:nth-child(1) > span:nth-child(1)',
                    attr: '', prefix: '', postfix: ''

lamoda_description_transformer =
    Transformer.create! mapping: lamoda_body_mapping, type: 'HasMany', name: 'Value Descriptions', key: 'descriptions_attributes',
                        order_key: 'order', source_key: 'source', element: '',
                        attr: '', prefix: '', postfix: ''
lamoda_description_header = Mapping.create! name: 'Description Header', scope: 'div.product-content__sheet', source: lamoda_description_transformer
Transformer.create! mapping: lamoda_description_header, type: 'Text', name: 'Description Text', key: 'text',
                    order_key: '', source_key: '', element: 'p.product-content__p',
                    attr: '', prefix: '', postfix: ''
lamoda_description_table = Mapping.create! name: 'Description Table', scope: 'table.product-content__table tr', source: lamoda_description_transformer
Transformer.create! mapping: lamoda_description_table, type: 'Text', name: 'Description Caption', key: 'caption',
                    order_key: '', source_key: '', element: 'th',
                    attr: '', prefix: '', postfix: ''
Transformer.create! mapping: lamoda_description_table, type: 'Text', name: 'Description Text', key: 'text',
                    order_key: '', source_key: '', element: 'td',
                    attr: '', prefix: '', postfix: ''

lamoda_promo_transformer =
    Transformer.create! mapping: lamoda_body_mapping, type: 'HasMany', name: 'Value Promos', key: 'promos_attributes',
                        order_key: 'order', source_key: '', element: '',
                        attr: '', prefix: '', postfix: ''
lamoda_promo_slider = Mapping.create! name: 'Description Table', scope: 'table.product-content__table tr', source: lamoda_promo_transformer
Transformer.create! mapping: lamoda_promo_slider, type: 'Attachment', name: 'Promo Image', key: 'image',
                    order_key: '', source_key: '', element: '',
                    attr: 'data-orig', prefix: 'http:', postfix: ''
Transformer.create! mapping: lamoda_promo_slider, type: 'AttributeValue', name: 'Promo Source', key: 'source',
                    order_key: '', source_key: '', element: '',
                    attr: 'data-orig', prefix: 'http:', postfix: ''
