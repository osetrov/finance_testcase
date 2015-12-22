class Share < ActiveRecord::Base
  has_many :share_items, dependent: :destroy
end
