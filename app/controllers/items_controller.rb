class ItemsController < ApplicationController
  # include ItemsHelper::InstanceHelper
  before_action :logged_in_user, except: [:home]
  layout 'item_layout', only: [:show]
  # layout false
  def index 
    # @user = User.find_by(params[:id])
    @purchases = current_user.purchases
  end
  
  def home 
    @items = Item.all
  end

  def new
    @item = Item.new
    5.times do 
      @item.images << Image.new
      @item.bulletings << Bulleting.new
    end
  end

  def show
    @item = Item.find params[:id]
    
  end

  def edit 
  end

  def update
  end

  def create 
    @item = Item.new item_params

    

    if @item.valid?
      images = images_params["images_attributes"]
      upload_images @item, images
      @item.save
      flash.now[:notice] = 'Your item was added successfully.'
      redirect_to @item 
    else
      5.times do 
        @item.images << Image.new
        @item.bulletings << Bulleting.new
      end 
      # binding.pry
      # redirect_to new_user_item_path(current_user)
      # p render_to_string '/items/new'
      # render plain: "OK"
      render :new#, location: new_user_item_path(current_user)
    end
  end

  private
   
  def item_params
    params.require(:item).permit(:title, :seller_id, :start_time, :end_time, :starting_price, :minimum_price, bulletings_attributes:{})
  end

  def images_params
    params.require(:item).permit(images_attributes: {})
  end

  def upload_images(item, images)
    if images
    images.each do |_, image|
      uploaded_file = image[:path]
      File.open(Rails.root.join('app', 'assets', 'images', uploaded_file.original_filename), 'wb') do |file|
        file.write(uploaded_file.read)
      end
      item.images << Image.create(path: uploaded_file.original_filename)
    end
  else
    
    item.images << Image.find_or_create_by(path: 'no_image.jpg')
  end
  end

  
end