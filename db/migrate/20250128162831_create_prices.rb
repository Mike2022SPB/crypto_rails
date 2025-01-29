class CreatePrices < ActiveRecord::Migration[7.2]
  def change
    create_table :prices do |t|
      t.decimal        :value
      t.datetime       :date
      t.references     :currency

      t.timestamps
    end
  end
end
