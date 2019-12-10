class Count < ActiveRecord::Base

  def self.import(file)

    workbook = Roo::Spreadsheet.open(file).sheet(0)
        
      ((workbook.first_row + 1)..workbook.last_row).each do |row|
        item_name = workbook.cell(row,'B') 
        item_qty = workbook.cell(row,'E').to_i
        item_price = workbook.cell(row,'D')

        edited_sku = []
        edited_sku_two = []
     
        singleSKU = item_name.scan(/\[.*?\]/) unless item_name == nil
        multipackSKU = item_name.match(/x\[.*?\]/) unless item_name == nil
        multipackSKU_qty = item_name.match(/\d*x\[/) unless item_name == nil

          singleSKU.each do |sku|
            edited_sku << sku.gsub(/(\[|\])/,"")
          end unless item_name == nil

          edited_sku.each do |sku|
            # puts "#{sku}\t#{item_qty}"
            blarg = sku.to_s + ","
            pblarg = blarg * item_qty
            bblarg = pblarg.split(",")
            bblarg.each { |o| Count.create(sku: o) }
          end

          if multipackSKU
            qty = multipackSKU_qty[0].chomp("x[").to_i-1
            stripped_sku = multipackSKU[0].sub("x", "")
            divided_sku = stripped_sku.to_s + ","
            edited_skus = divided_sku * qty
            separated_skus = edited_skus.split(",")
            separated_skus.each { |sku| edited_sku_two << sku.gsub(/(\[|\])/,"") } unless item_name == nil
            
            edited_sku_two.each do |sku|
              # puts "#{sku}\t#{item_qty}"
              blarg = sku.to_s + ","
              pblarg = blarg * item_qty
              bblarg = pblarg.split(",")
              bblarg.each { |o| Count.create(sku: o) }
            end
          end
      end
  end
end

