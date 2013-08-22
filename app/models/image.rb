class Image < ActiveRecord::Base
  default_scope order: 'images.created_at DESC'
end
