class CreateFilings < ActiveRecord::Migration
  def change
    create_table :filings do |t|
      t.integer :stock_id
      t.integer :type, default: 0
      t.string  :acn
      t.integer :year

      t.timestamps
    end
  end
end
