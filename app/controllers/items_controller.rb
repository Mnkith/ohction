class ItemsController < ApplicationController
  before_action :logged_in_user, except: [:home]
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :all_items, only: [:home, :destroy]
  before_action :verify_owner, only: [:edit, :destroy]
  layout 'item_layout', only: [:show]

  def index
    @purchases = current_user.purchases
  end

  def home
    if params[:status] && !params[:status].empty?
      @items = Item.filter_by_status(params[:status])
    end
  end

  def new
    @item = Item.new
    @item.instanciate_nested_attributes
  end

  def show
  end

  def edit
  end

  def update
    if @item.update item_params
      redirect_to user_items_path(current_user), notice: 'Item was updated successfully.'
    else
      render :edit
    end
  end

  def create
    @item = Item.new item_params
    if @item.valid?
      images = images_params['images_attributes']
      upload_images @item, images
      @item.save
      redirect_to user_items_path(current_user), notice: 'Your item was added successfully.'
    else
      @item.instanciate_nested_attributes
      render :new 
    end
  end

  def destroy 
    @item.destroy
    render :home
  end



  private

  def find_item
    @item = Item.find_by id: params[:id]
  end

  def all_items
    @items  = Item.all
  end

  def item_params
    params.require(:item).permit(:title, :seller_id, :start_time, :end_time, :starting_price, :minimum_price, :status,
                                 bulletings_attributes: {})
  end

  def verify_owner
    unless Item.find_by(id: params[:id]).seller == current_user
      render file: "#{Rails.root}/public/404.html",
             layout: false
    end
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
