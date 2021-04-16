module ItemsHelper 
  module InstanceHelper
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::FormHelper
    include ActionView::Context
    # include ActionController
    include Rails.application.routes.url_helpers

    
    
    
    def started?
      Item.dezone(Time.now) >= Item.dezone(start_time)
    end

    def ended?
      Item.dezone(Time.now) >= Item.dezone(end_time)
    end
    
    def sold?
      ended? && (current_price + starting_price) > minimum_price
    end
    
    def active?
      started? && !ended?
    end

    def set_sold
      self.images.clear
      self.images << Image.find_or_create_by(path: 'sold.jpg')
      self.buyer_id = Bid.last.user_id
      self.save
    end

    def owned_by? current_user
      # binding.pry
      seller == current_user
    end

    def display_as_sold 
      tag.li('This item is sold', class: 'list-group-item' ) <<
      tag.li("Auction ended at: #{end_time}") << 
      tag.li("Item bought by: #{buyer.name}")<< 
      tag.li("Item sold for: #{current_price + starting_price}") 
    end

    def display_as_owned
      tag.li 'Your the owner of this item', class: 'list-group-item'
      item.active? ? tag.li("Can't Edit an item under active auction", class: 'list-group-item') : tag.li(tag.a("Edit this item", href: edit_item_path(item)), class: 'list-group-item')
    end

    def display_as_active
      tag.li("Auction started at: #{start_time}", class: 'list-group-item')  <<
      tag.li("Auction will end at: #{end_time}", class: 'list-group-item')  <<
      tag.li("Starting price: $#{starting_price}", class: 'list-group-item') <<
      tag.li("Shipping: $#{shipping}", class: 'list-group-item') <<
      tag.li("Current price: $#{starting_price + current_price}", class: 'list-group-item') 
      # form_with(model: Bid.new, url: item_bids_path(@item), controller: :bid, action: :create) do |f|
      #   # f.hidden_field(:item_id, value: self.id) <<
      #   f.number_field( :amount ) <<
      #   f.submit('Place your bid')
      # end
    end

    def status_based_display 
      if sold?
        display_as_sold
      elsif active?
        display_as_active
      else
        tag.li("Auction will start at: #{start_time}", class: 'list-group-item')  <<
        tag.li("Auction will end at: #{end_time}", class: 'list-group-item')  <<
        tag.li("Starting price: $#{starting_price}", class: 'list-group-item') <<
        tag.li("Shipping: $#{shipping}", class: 'list-group-item')
  
        
      end
    
    end

    # def display_as_active item
    #   tag.li("Auction started at: #{item.start_time}", class: 'list-group-item')  <<
    #   tag.li("Auction will end at: #{item.end_time}", class: 'list-group-item')  <<
    #   tag.li("Starting price: $#{item.starting_price}", class: 'list-group-item') <<
    #   tag.li("Shipping: $#{item.shipping}", class: 'list-group-item') <<
    #   tag.li("Current price: $#{item.starting_price + item.current_price}", class: 'list-group-item') <<
    #   # form_tag("/items/#{item.id}/bids") do
    #   #   hidden_field_tag name:"authenticity_token", value:"#{form_authenticity_token}">
    #   #   # f.hidden_field(:item_id, value: self.id) <<
    #   #   number_field_tag( :amount ) <<
    #   #   submit_tag('Place your bid')
    #   # end
    # end

    
    
  end

  



  

  

  module ClassHelper
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::FormHelper
    include Rails.application.routes.url_helpers

    def dezone(time)
      time.strftime('%Y-%m-%d %H:%M:%S')
    end

    

    
    def diplay_all_items
      Item.all.map do |item|
        tag.div id: 'carouselExampleSlidesOnly', class: 'carousel slide' do
          tag.div class: 'carousel-inner' do
            tag.div class: 'carousel-item active p-1 border bg-dark' do
              item.images.each do |image|
                image_tag image.path, class: 'd-block w-30 img-fluid'
              end
            end
          end
        end
      end
    end
  end
end
