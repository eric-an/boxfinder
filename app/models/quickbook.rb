class Quickbook < ActiveRecord::Base

  def self.import(file)
    workbook = Roo::Spreadsheet.open(file).sheet(1)
      ((workbook.first_row + 1)..workbook.last_row).each do |row|
        item_sku = workbook.cell(row,'A')
        item_name = workbook.cell(row,'B')
        Quickbook.create(sku: item_sku, name: item_name, counter: 0)
    end
  end

  def count_skus(quickbook)
    quickbook.counter = 0
    Count.all.each do |count|
      if quickbook.sku == count.sku
        quickbook.counter += 1
        quickbook.save
      end
    end 
    quickbook.counter
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |quickbook|
        csv << quickbook.attributes.values_at(*column_names)
      end
    end
  end

end
