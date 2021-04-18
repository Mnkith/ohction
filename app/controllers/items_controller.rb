class ItemsController < ApplicationController
  before_action :logged_in_user, except: [:home]
  before_action :verify_owner, only: [:edit]
  # before_action :update_status, only: %i[show home index]
  layout 'item_layout', only: [:show]
  # layout false
  def index
    # @user = User.find_by(params[:id])
    @purchases = current_user.purchases
  end

  def home
    # binding.pry
    if !params[:status].empty?
      @items = Item.filter_by_status(params[:status])
    else
      @items  = Item.all
    end
  end

  def new
    @item = Item.new
    @item.instanciate_nested_attributes
  end

  def show
    @item = Item.find params[:id]
  end

  def edit
    # binding.pry
    @item = Item.find_by id: params[:id]
    # @item.instanciate_nested_attributes
  end

  def update; end

  def create
    @item = Item.new item_params

    # binding.pry

    if @item.valid?
      images = images_params['images_attributes']
      upload_images @item, images
      @item.save
      redirect_to @item, notice: 'Your item was added successfully.'
    else
      @item.instanciate_nested_attributes
      render :new # , location: new_user_item_path(current_user)
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :seller_id, :start_time, :end_time, :starting_price, :minimum_price, :status,
                                 bulletings_attributes: {})
  end

  def verify_owner
    # render html: helpers.tag.strong('Not Found')
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
