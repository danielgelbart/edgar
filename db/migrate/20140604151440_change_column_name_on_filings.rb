class ChangeColumnNameOnFilings < ActiveRecord::Migration
  def change
    rename_column :filings, :type, :filing_type
  end
end
