class PortfolioFinance < ActiveRecord::Base
  belongs_to :user
  has_many :share_items, dependent: :destroy

  def add_share_item share_item
    share_items << share_item
  end

  def total_ask_last_trade
    share_items.to_a.sum {|item| item.ask_last_trade }
  end

  def historical_quotes start_date, end_date, symbols_share = []

      if symbols_share.nil? or symbols_share.size < 1
        symbols_share = Share.all.map(&:symbol)
      end

      select_shares = Share.where(:symbol => symbols_share)
      select_share_items = share_items.where(:share_id =>select_shares.map(&:id).uniq)
      result = select_share_items.first.historical_quotes start_date, end_date
      select_share_items.each do |share_item|
        if share_item != select_share_items.first
          result = result.merge(share_item.historical_quotes start_date, end_date){ |k, b_value, a_value|
            a_value + b_value
          }
        end
      end

      result
    end
end
