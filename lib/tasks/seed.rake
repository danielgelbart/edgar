# Get edgar accesion numbers of annual reports on edgar
namespace :seed do
  desc "Seed stocks and accesions for 10-ks"

  task :cik_and_acns => :environment do |task, args|
    require 'active_record'

    file = File.open("accession_numbers.txt","r")

    # skip first line wich is just a title
    lines = file.lines
    lines.next

    lines.each do |line|

      if line.first == "N"
        name, ticker, cik =
          line.scan(/Name: (.+) ; Ticker: (.+) ; CIK: (\d+).+/)[0]

        stock = Stock.create(:name => name,
                             :ticker => ticker,
                             :cik => cik)

        # write errors to erro log
      else
        year,acn = line.scan(/YEAR (\d+) ; ACN (.+)/)[0]
        fil = Filing.create(:stock => stock,
                            :year => year,
                            :filing_type => "k10",
                            :acn => acn)

      end
    end


    file.close
  end # task



end # namdspace
