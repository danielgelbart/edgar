# == Schema Information
#
# Table name: filings
#
#  id         :integer          not null, primary key
#  stock_id   :integer
#  type       :integer          default(0)
#  acn        :string(255)
#  year       :integer
#  created_at :datetime
#  updated_at :datetime
#

class Filing < ActiveRecord::Base
  belongs_to :stock
  enum type: [ :10_k, :10_q]
end
