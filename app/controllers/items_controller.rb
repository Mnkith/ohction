class ItemsController < ApplicationController
  layout false
  def index 
    @items = Item.all
  end

  def new
    @item = Item.new
    3.times do 
      @item.images << Image.new
      @item.bulletings << Bulleting.new
    end
  end

  def show
  end

  def update
  end

  def create 
    item_params
    binding.pry
  end

  private
   
  def item_params
    params.require(:item).permit(:title, :start_time, :end_time)
  end

  
end