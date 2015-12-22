class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.string :title
      t.string :symbol
      t.timestamps null: true
    end
    Share.create(title: "Apple", symbol: "AAPL")
    Share.create(title: "Google", symbol: "GOOG")
    Share.create(title: "Yahoo", symbol: "YHOO")
    Share.create(title: "Yandex", symbol: "YNDX")
    Share.create(title: "Microsoft", symbol: "MSFT")
    Share.create(title: "Oracle", symbol: "ORCL")

  end
end
