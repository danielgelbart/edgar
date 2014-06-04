# == Schema Information
#
# Table name: stocks
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  ticker     :string(255)
#  cik        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Stock < ActiveRecord::Base
  has_many :filings

  validates_presence_of :cik
  validates_uniqueness_of :cik

  validates_presence_of :ticker
  validates_uniqueness_of :ticker


end
