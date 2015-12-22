class ShareItem < ActiveRecord::Base
  belongs_to :portfolio_finance
  belongs_to :share
end
