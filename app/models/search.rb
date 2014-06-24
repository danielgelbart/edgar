# == Schema Information
#
# Table name: searches
#
#  id         :integer          not null, primary key
#  filtype    :integer          default(0)
#  ticker     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Search < ActiveRecord::Base
  enum filtype: [ :k10, :q10]

  def generate_links(ticker)
    file = File.open("accession_numbers.txt","r")
    lines = file.lines
    list = nil
    at_line = false
    lines.each do |line|

      if at_line == false && get_ticker(line) == ticker.strip
        cik = line.split(";")[2][/ CIK: (?<tik>.*)/,"tik"].strip
        list = AcnList.new(ticker,cik)
        at_line = true
        next
      end

      if at_line
        break if line.first == "N"
        year, acn = retrieve_acn_info(line)
        list.add(Acn.new(year,list.cik,acn))
      end
    end

    file.close
    list
  end

  def get_ticker(line)
    tik = line.split(";")[1][/ Ticker: (?<tik>.*)/,"tik"]
    return "" if tik.nil?

    puts ("ticker is #{tik}")

    tik.strip
  end

  def retrieve_acn_info(line)
    acn_data = []
    acn_data << line.split(";")[0][/YEAR (?<tik>.*)/,"tik"].strip
    acn_data << line.split(";")[1][/ACN (?<tik>.*)/,"tik"].strip
    acn_data
  end
end



class Acn
  attr_accessor :ticker, :year, :acn, :cik

  def initialize(year,cik,acn)
    @year = year
    @acn = acn
    @cik = cik
  end

  def url
    "http://www.sec.gov/Archives/edgar/data/#{cik}/#{acn}.txt"
  end
end

class AcnList
  attr_accessor :ticker, :cik, :list

  def initialize(ticker, cik)
    @ticker = ticker
    @cik = cik
    @list = []
  end

  def add(acn)
    @list << acn
  end
end



