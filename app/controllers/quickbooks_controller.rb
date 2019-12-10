class QuickbooksController < ApplicationController

  def index
    @quickbook = Quickbook.all
    @quickbooks = Quickbook.order(:name)
    @quickbook.each { |quick| quick.count_skus(quick) } 
    
    respond_to do |format|
      format.html
      format.csv { send_data @quickbooks.to_csv }
      format.xls # { send_data @quickbooks.to_csv(col_sep: "\t") }
    end
  end

  def import
    Quickbook.import(params[:file])
    redirect_to quickbooks_url, notice: "Quickbook imported."
  end

end
