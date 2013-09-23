class ApplicationCategory < ActiveRecord::Base
  belongs_to :application, dependent: :destroy, inverse_of: :application_categories
  belongs_to :category, dependent: :destroy, inverse_of: :application_categories

end
