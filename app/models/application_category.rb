class ApplicationCategory < ActiveRecord::Base
  belongs_to :application, inverse_of: :application_categories
  belongs_to :category, inverse_of: :application_categories

end
