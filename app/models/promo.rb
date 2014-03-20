class Promo < ActiveRecord::Base
  belongs_to :value, touch: true, inverse_of: :promos

  Paperclip.interpolates :value_id do |attachment, style|
    attachment.instance.value_id
  end

  has_attached_file :image, styles: {xhdpi: ['100%', :png], hdpi: ['75%', :png], mdpi: ['50%', :png], ldpi: ['37%', :png], thumb: ['100x100', :png]},
                    default_style: :xhdpi, url: '/p/:value_id/:id/:style/:hash.:extension',
                    hash_secret: '933QPmmE2uEvGULxSw4jvWEh'
  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png)

end
