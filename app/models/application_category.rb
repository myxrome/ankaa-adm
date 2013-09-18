class ApplicationCategory < ActiveRecord::Base
  belongs_to :application
  belongs_to :category

end
