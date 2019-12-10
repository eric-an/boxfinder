class CountsController < ApplicationController
  before_action :set_count, only: [:show, :edit, :update, :destroy]

  def import
    Count.import(params[:file])
    redirect_to counts_url, notice: "Count imported."
  end

  def index
    @counts = Count.all
  end

  def show
  end


  def new
  end

  def edit
  end


  def create
  end

  def update
  end

  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_count
      @count = Count.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def count_params
      params.require(:count).permit(:sku)
    end
end
