class ApplicationCategory < ActiveRecord::Base
  belongs_to :application, dependent: :destroy
  belongs_to :category, dependent: :destroy

end
