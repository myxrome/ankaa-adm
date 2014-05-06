module ValuesHelper
  require 'open-uri'

  @@current_order = 0

  Map = [
      {
          url: 'http://www.lamoda.ru',
          mapping: {
              scope: 'body',
              data: [
                  {
                      key: :name,
                      type: :text,
                      selector: 'a.product-card__header-link'
                  },
                  {
                      key: :new_price,
                      type: :text,
                      selector: 'span.price_product'

                  },
                  {
                      key: :descriptions_attributes,
                      type: :has_many,
                      selector: [
                          {
                              scope: 'div.product-content__sheet',
                              data: [
                                  {
                                      key: :text,
                                      type: :text,
                                      selector: 'p.product-content__p'
                                  },
                                  {
                                      key: :order,
                                      type: :order
                                  }
                              ]
                          },
                          {
                              scope: 'table.product-content__table tr',
                              data: [
                                  {
                                      key: :caption,
                                      type: :text,
                                      selector: 'th'
                                  },
                                  {
                                      key: :text,
                                      type: :text,
                                      selector: 'td'
                                  },
                                  {
                                      key: :order,
                                      type: :order
                                  }
                              ]
                          }
                      ]
                  },
                  {
                      key: :promos_attributes,
                      type: :has_many,
                      selector: [
                          {
                              scope: 'li.photos-list__item',
                              data: [
                                  {
                                      key: :image,
                                      type: :attachment,
                                      selector: '',
                                      attribure: 'data-orig',
                                      prefix: 'http:'
                                  },
                                  {
                                      key: :order,
                                      type: :order
                                  }
                              ]
                          }
                      ]
                  }
              ]
          }}]

  def self.params_from_url(url)
    mapping = Map.select { |item| url.downcase.start_with? item[:url] }.first[:mapping]
    doc = Nokogiri::HTML(open(url))

    ValuesHelper.params_from_scope(doc.css(mapping[:scope]), mapping[:data]).merge({url: url})
  end

  def self.params_from_scope(scope, data)
    result = Hash.new
    data.each { |item| result.merge! ({item[:key] => ValuesHelper.send(item[:type], item, scope)}) }
    result
  end

  def self.text(item, scope)
    scope.css(item[:selector]).inner_text.strip
  end

  def self.has_many(item, scope)
    result = Hash.new
    @@current_order = 0
    item[:selector].each { |item|
      scope.css(item[:scope]).each { |element|

        result.merge!({rand(100000000).to_s => ValuesHelper.params_from_scope(element, item[:data])})
      }
    }
    result
  end

  def self.attachment(item, scope)
    node = item[:selector].empty? ? scope : scope.css(item[:selector])
    url = item[:prefix] + node[item[:attribure]]
    URI.parse(url)
  end

  def self.order(item, scope)
    @@current_order = @@current_order + 1
  end

end
