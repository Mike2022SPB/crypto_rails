class CreateCurrencies < ActiveRecord::Migration[7.2]
  def change
    create_table :currencies do |t|
      t.string      :title
      t.string      :coin_symbol

      t.timestamps
    end
  end
end
