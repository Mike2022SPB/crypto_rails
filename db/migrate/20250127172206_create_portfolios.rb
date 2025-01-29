class CreatePortfolios < ActiveRecord::Migration[7.2]
  def change
    create_table :portfolios do |t|
      t.references :user
      t.decimal    :portfolio_value, default: 0

      t.timestamps
    end
  end
end
