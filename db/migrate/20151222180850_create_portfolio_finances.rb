class CreatePortfolioFinances < ActiveRecord::Migration
  def change
    create_table :portfolio_finances do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :title

      t.timestamps null: false
    end
  end
end
