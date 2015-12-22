class CreateShareItems < ActiveRecord::Migration
  def change
    create_table :share_items do |t|
      t.belongs_to :portfolio_finance, index: true, foreign_key: true
      t.belongs_to :share, index: true, foreign_key: true
      t.integer :quantity
    end
  end
end
