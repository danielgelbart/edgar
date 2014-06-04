class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :name
      t.string :ticker
      t.string :cik

      t.timestamps
    end
  end
end
