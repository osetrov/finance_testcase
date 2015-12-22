class ShareItem < ActiveRecord::Base
  belongs_to :portfolio_finance
  belongs_to :share

  def ask_last_trade
    Rails.cache.fetch('share_item_ask_last_trade_' + share.symbol.to_s + quantity.to_s, :expires_in => 5.minutes) do
      yahoo_client = YahooFinance::Client.new
      data = yahoo_client.quotes([share.symbol], [:ask, :bid, :last_trade_date], { raw: false } )
      if data[0].present? and data[0][:ask].present?
        return data[0][:ask].to_f * quantity
      end
      0.0
    end
  end

  def historical_quotes start_date, end_date
    Rails.cache.fetch('share_item_historical_quotes' + share.symbol.to_s + quantity.to_s + start_date.to_s +
                          end_date.to_s, :expires_in => 1.day) do
      yahoo_client = YahooFinance::Client.new
      data = yahoo_client.historical_quotes(share.symbol, { start_date: start_date, end_date: end_date,
                                                            period: :monthly })
      result = Hash.new
      data.each do |item|
        result[DateTime.parse(item.trade_date).strftime('%Y-%m-%d 00:00:00')] = item.high.to_f * quantity
      end
      result
    end
  end

end
