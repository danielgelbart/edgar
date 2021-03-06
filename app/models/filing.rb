# == Schema Information
#
# Table name: filings
#
#  id          :integer          not null, primary key
#  stock_id    :integer
#  filing_type :integer          default(0)
#  acn         :string(255)
#  year        :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Filing < ActiveRecord::Base
  belongs_to :stock
  enum filing_type: [ :k10, :q10]

  validates_presence_of :acn
  validates_uniqueness_of :acn

end
