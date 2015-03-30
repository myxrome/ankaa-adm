class WomenTopicGroup < SeedMigration::Migration
  def up
    lamoda_scraper = Scraper.find_by(name: 'Lamoda')
    showrooms_scraper = Scraper.find_by(name: 'Showrooms')
    butik_scraper = Scraper.find_by(name: 'Butik')

    TopicGroup.find_or_create_by! key: 'da46a5a8de1577cecf9baed38d4fe65c' do |topic_group|
      topic_group.update_attributes! order: 1, name: 'Женщинам', active: true

      Topic.create! topic_group: topic_group, order: 1, name: 'Женская Одежда', displayed_name: 'Одежда',
                    active: true do |topic|
        Category.create! topic: topic, order: 1, name: 'Женская Верхняя Одежда', displayed_name: 'Верхняя Одежда',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/357/clothes-verkhnyaya-odezhda/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/odejda/verkhnyaya-odezhda/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskaja-odezhda/verhnjaja-odezhda/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 2, name: 'Женские Платья и Сарафаны', displayed_name: 'Платья и Сарафаны',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/369/clothes-platiya/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/odejda/platya-sarafani/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskaja-odezhda/platja/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 3, name: 'Женские Джемперы и Кардиганы', displayed_name: 'Джемперы и Кардиганы',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/371/clothes-trikotazh/?genders=women&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/odejda/djemperi-kardigani/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskaja-odezhda/dzhempery-i-svitery/sale/?page=',
                                      url_postfix: '', limit: 10},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskaja-odezhda/kardigany/sale/?page=',
                                      url_postfix: '', limit: 10},
                                 ])
          end
        end

        Category.create! topic: topic, order: 4, name: 'Женские Блузы и Рубашки', displayed_name: 'Блузы и Рубашки',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/399/clothes-bluzy-rubashki/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/odejda/bluzy-rubashki/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskaja-odezhda/bluzy-i-rubashki/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 5, name: 'Женские Брюки', displayed_name: 'Брюки',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/401/clothes-bryuki-shorty-kombinezony/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/odejda/bryuki-kombinezoni/bryuki/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 10},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/odejda/bryuki-kombinezoni/bridji-kapri/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 10},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskaja-odezhda/brjuki/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 6, name: 'Женские Комбинезоны', displayed_name: 'Комбинезоны',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/4184/clothes-coveralls/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/odejda/bryuki-kombinezoni/kombinezoni/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskaja-odezhda/kombinezony/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 7, name: 'Женские Юбки', displayed_name: 'Юбки',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/423/clothes-yubki/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/odejda/yubki/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskaja-odezhda/jubki/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end


        Category.create! topic: topic, order: 8, name: 'Женские Джинсы', displayed_name: 'Джинсы',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/397/clothes-d-insy/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/odejda/dzhinsy/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskaja-odezhda/dzhinsy/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 9, name: 'Женские Толстовки и Олимпийки', displayed_name: 'Толстовки и Олимпийки',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/2474/clothes-tolstovki-olimpiyki/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/odejda/tolstovki/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskaja-odezhda/tolstovki-i-svitshoti/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 10, name: 'Женские Пиджаки и Костюмы', displayed_name: ' Пиджаки и Костюмы',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/367/clothes-pidzhaki-zhaketi/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/odejda/pidjaki-jaketi/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskaja-odezhda/zhakety-i-pidzhaki/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 11, name: 'Женские Футболки и Топы', displayed_name: 'Футболки и Топы',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/2478/clothes-futbolki/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 10},
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/2627/clothes-topy/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 10},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/odejda/futbolki-topi/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskaja-odezhda/futbolki/sale/?page=',
                                      url_postfix: '', limit: 10},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskaja-odezhda/majki-i-topy/sale/?page=',
                                      url_postfix: '', limit: 10},
                                 ])
          end
        end

        Category.create! topic: topic, order: 12, name: 'Женские Шорты', displayed_name: 'Шорты',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/2485/clothes-shorty/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/odejda/shorti/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskaja-odezhda/shorty/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

      end

      Topic.create! topic_group: topic_group, order: 2, name: 'Женская Обувь', displayed_name: 'Обувь',
                    active: true do |topic|

        Category.create! topic: topic, order: 1, name: 'Женские Сапоги', displayed_name: 'Сапоги',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/21/shoes-sapogi/?genders=women&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/obuv/polusapogi/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 10},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/obuv/sapogi/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 10},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/obuv/botforty/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 10},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/obuv/dlja-zhenwin/sapogi/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 2, name: 'Женские Ботинки', displayed_name: 'Ботинки',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/23/shoes-botinki/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/obuv/polubotinki/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 10},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/obuv/botinki/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 10},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/obuv/dlja-zhenwin/botinki/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 3, name: 'Женские Ботильоны', displayed_name: 'Ботильоны',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/2448/shoes-botilony/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/obuv/botolioni/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/obuv/dlja-zhenwin/botilony/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 4, name: 'Женские Кроссовки и Кеды', displayed_name: 'Кроссовки и Кеды',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/2968/shoes-krossovki-kedy/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/obuv/krossovki/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 10},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/obuv/kedy/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 10},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/obuv/dlja-zhenwin/kedy/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 5, name: 'Женские Туфли', displayed_name: 'Туфли',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/33/shoes-tufli/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/obuv/tufli/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/obuv/dlja-zhenwin/tufli/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 6, name: 'Женские Угги и Валенки', displayed_name: 'Угги и Валенки',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/91/shoes-uggi-and-unty/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 10},
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/2432/shoes-zhenskie-valenki/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 10},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/obuv/uggi/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/obuv/dlja-zhenwin/uggi/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 7, name: 'Женские Босоножки', displayed_name: 'Босоножки',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/39/shoes-bosonozhki/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/obuv/bosonojki/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/obuv/dlja-zhenwin/bosonozhki/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 8, name: 'Женские Балетки', displayed_name: 'Балетки',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/37/shoes-baletki/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/obuv/baletki/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/obuv/dlja-zhenwin/baletki/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 9, name: 'Женские Сандалии', displayed_name: 'Сандалии',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/127/shoes-sandalii/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/obuv/sandalii/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/obuv/dlja-zhenwin/sandalii/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 10, name: 'Женские Мокасины и Эспадрильи', displayed_name: 'Мокасины и эспадрильи',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/35/shoes-mokasiny/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/obuv/mokasini/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/obuv/dlja-zhenwin/mokasiny-i-topsaidery/sale/?page=',
                                      url_postfix: '', limit: 10},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/obuv/dlja-zhenwin/espadrili/sale/?page=',
                                      url_postfix: '', limit: 10},
                                 ])
          end
        end

        Category.create! topic: topic, order: 11, name: 'Женские Сланцы', displayed_name: 'Сланцы',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/207/shoes-slantsi/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/obuv/slanci/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/obuv/dlja-zhenwin/slancy/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 12, name: 'Женские Сабо', displayed_name: 'Сабо',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/41/shoes-sabo/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 30},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/obuv/sabo/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 30},
                                 ])
          end
        end

      end

      Topic.create! topic_group: topic_group, order: 3, name: 'Женская Аксессуары', displayed_name: 'Аксессуары',
                    active: true do |topic|

        Category.create! topic: topic, order: 1, name: 'Женские Сумки', displayed_name: 'Сумки',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/565/bags-sumki/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/aksessuari/sumki/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/sumki-portfeli/dlja-zhenwin/sumki/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 2, name: 'Женские Головные Уборы', displayed_name: 'Головные Уборы',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/647/hats-golovnyeubory/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/aksessuari/shapki-shlyapi/?discount_min=1&discount_max=100&page=1',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskie-aksessuary/golovnye-ubory/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 3, name: 'Женские Платки и Шарфы', displayed_name: 'Платки и Шарфы',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/683/scarfs-platki-i-sharfy/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/aksessuari/sharfi-platki/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskie-aksessuary/sharfy-i-platki/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 4, name: 'Женские Перчатки и Варежки', displayed_name: 'Перчатки и Варежки',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/815/accs-perchatki-i-varezhki/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/aksessuari/perchatki-varejki/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskie-aksessuary/perchatki/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 5, name: 'Женские Зонты', displayed_name: 'Зонты',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/783/accs-zonty/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/aksessuari/zonti/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskie-aksessuary/zonty/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 6, name: 'Женские Портмоне и Кошельки', displayed_name: 'Портмоне и Кошельки',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/3096/accs-portmone-women/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/aksessuari/koshelki-portmone/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskie-aksessuary/koshelki-i-portmone/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 7, name: 'Женские Косметички', displayed_name: 'Косметички',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/775/bags-kosmetichki/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/aksessuari/kosmetichki/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskie-aksessuary/kosmetichki/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 8, name: 'Женские Рюкзаки', displayed_name: 'Рюкзаки',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/567/bags-ryukzaki/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 30},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/aksessuari/ryukzaki/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 30},
                                 ])
          end
        end

        Category.create! topic: topic, order: 9, name: 'Женские Очки', displayed_name: 'Очки',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/2395/accs_ns-ochki/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/aksessuari/ochki/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskie-aksessuary/solncezashitnie-ochki/sale/?page=',
                                      url_postfix: '', limit: 20},
                                 ])
          end
        end

        Category.create! topic: topic, order: 10, name: 'Женские Ремни и Пояса', displayed_name: 'Ремни и пояса',
                         active: true do |category|
          Miner.create! category: category do |miner|
            MinerScraper.create!([
                                     {miner: miner, scraper: lamoda_scraper,
                                      url_prefix: 'http://www.lamoda.ru/c/701/accs-remni/?genders=women%2Cunisex&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: showrooms_scraper,
                                      url_prefix: 'http://showrooms.ru/women/aksessuari/remni/?discount_min=1&discount_max=100&page=',
                                      url_postfix: '', limit: 20},
                                     {miner: miner, scraper: butik_scraper,
                                      url_prefix: 'http://www.butik.ru/zhenskie-aksessuary/remni/sale/?page=',
                                      url_postfix: '', limit: 20},
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
