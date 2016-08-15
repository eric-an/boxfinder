class Quickbook < ActiveRecord::Base

  def self.import(file)
    workbook = Roo::Spreadsheet.open(file).sheet(1)
      ((workbook.first_row + 1)..workbook.last_row).each do |row|
        item_sku = workbook.cell(row,'A') 
        item_qty = workbook.cell(row,'E').to_i
        item_price = workbook.cell(row,'D')
    end
  end
end
