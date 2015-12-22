json.array!(@portfolio_finances) do |portfolio_finance|
  json.extract! portfolio_finance, :id, :user_id, :title
  json.url portfolio_finance_url(portfolio_finance, format: :json)
end
