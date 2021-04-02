class ItemsController < ApplicationController
  # layout false
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
    if @item.valid?
      images = images_params["images_attributes"]
      upload_images @item, images
      @item.save
      redirect_to @item, notice: 'Your item was added successfully.'
    else
      binding.pry
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

  def images_params
    params.require(:item).permit(images_attributes: {})
  end

  def upload_images(item, images)
    images.each do |_, image|
      uploaded_file = image[:path]
      File.open(Rails.root.join('app', 'assets', 'images', uploaded_file.original_filename), 'wb') do |file|
        file.write(uploaded_file.read)
      end
      item.images << Image.create(path: uploaded_file.original_filename)
    end
  end

  
end