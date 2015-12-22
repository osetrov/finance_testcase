class PortfolioFinance < ActiveRecord::Base
  belongs_to :user
  has_many :share_items, dependent: :destroy

  def add_share_item share_item
    share_items << share_item
  end
end
