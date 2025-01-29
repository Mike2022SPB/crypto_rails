class CreatePortfolioCurrencies < ActiveRecord::Migration[7.2]
  def change
    create_table :portfolio_currencies do |t|
      t.references  :portfolio
      t.references  :currency
      t.decimal     :amount

      t.timestamps
    end
  end
end
