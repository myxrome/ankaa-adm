class WomenTopicGroup < SeedMigration::Migration
  def up
    lamoda_scraper = Scraper.find_by(name: 'Lamoda')
    wildberries_scraper = Scraper.find_by(name: 'Wildberries')

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

  end

  def down
    TopicGroup.find_by(key: 'da46a5a8de1577cecf9baed38d4fe65c').each do |t|
      t.delete
    end
  end
end
