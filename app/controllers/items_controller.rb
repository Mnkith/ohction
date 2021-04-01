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
  end

  
end