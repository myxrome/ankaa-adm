namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do

    Category.create! name: 'Kids Toys'
    Category.create! name: 'Kids Wear'
    Category.create! name: 'Women Wear'
    Category.create! name: 'Men Wear'

    Application.create! name: 'For Kids', category_ids: [1, 2]
    Application.create! name: 'For Men', category_ids: [4]
    Application.create! name: 'For Women', category_ids: [3]

    DescriptionTemplate.create! caption: 'Location'
    DescriptionTemplate.create! caption: 'Locale'
    DescriptionTemplate.create! caption: 'Size'
    DescriptionTemplate.create! caption: 'Color'

    Value.create! name: 'Best Price Ever', category_id: 3, old_price: '100', discount: '90%', new_price: '10', url:
        'http://vendor.com', end_date: 7.days.from_now, active: false
    Description.create! description_template_id: 1, value_id: 1, text: 'all locations', bold: true, red: false, order: 1
    Description.create! description_template_id: 3, value_id: 1, text: 'all sizes', bold: false, red: true, order: 2

    Value.create! name: 'New Value', category_id: 1, old_price: '100', discount: '90%', new_price: '10', url:
        'http://vendor.com', end_date: 10.days.from_now, active: true
    Description.create! description_template_id: 2, value_id: 2, text: 'all locales', bold: true, red: false, order: 1
    Description.create! description_template_id: 4, value_id: 2, text: 'black only', bold: false, red: true, order: 2

  end
end