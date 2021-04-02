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
    @item = Item.new item_params
    if @item.save
      redirect_to @item, notice: 'Your item was added successfully.'
    else
      # binding.pry
      # redirect_to new_user_item_path(current_user)
      # p render_to_string '/items/new'
      # render plain: "OK"
      render :new, location: new_user_item_path(current_user)
    end
  end

  private
   
  def item_params
    params.require(:item).permit(:title, :seller_id, :start_time, :end_time)
  end

  
end