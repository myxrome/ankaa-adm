class Partner < ActiveRecord::Base

  has_attached_file :logo, url: '/l/:id/:hash.:extension', hash_secret: '933QPmmE2uEvGULxSw4jvWEh'
  validates_attachment_content_type :logo, :content_type => %w(image/jpeg image/jpg image/png)

end
