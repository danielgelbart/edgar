class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.integer :filtype, default: 0
      t.string :ticker

      t.timestamps
    end
  end
end
