module ItemsHelper 
  module InstanceHelper
    include ActionView::Helpers::TagHelper
    # include ActionView::Helpers::FormHelper
    # include ActionView::Context
    # include ActionController
    # include Rails.application.routes.url_helpers

    
    
    
    def started?
      Item.dezone(Time.now) >= Item.dezone(start_time)
    end

    def ended?
      Item.dezone(Time.now) >= Item.dezone(end_time)
    end
    
    def sold?
      ended? && current_price >= minimum_price
    end

    def failed?
      ended? && current_price < minimum_price
    end
    
    def active?
      started? && !ended?
    end

    def pending?
      !started?
    end

    # def set_status
    #   if active?
    #     status = 'active'
    #   elsif sold?
    #     status = 'sold'
    #     set_sold
    #   elsif failed?
    #     status = 'failed'
    #   end
    # end



    # def set_sold
    #   self.images.clear
    #   self.images << Image.find_or_create_by(path: 'sold.jpg')
    #   self.buyer_id = Bid.last.user_id
    #   # self.save
    # end

    def owned_by? current_user
      seller == current_user
    end

    def display_as_sold 
      tag.li("Status: #{status}", class: 'list-group-item' ) <<
      tag.li("Listed by: #{seller.name}", class: 'list-group-item' ) <<
      tag.li("Auction started at: #{start_time}", class: 'list-group-item', class: 'list-group-item') << 
      tag.li("Auction ended at: #{end_time}", class: 'list-group-item') << 
      tag.li("Item bought by: #{buyer.name}", class: 'list-group-item')<< 
      tag.li("Item sold for: $#{current_price + starting_price}", class: 'list-group-item') 
    end

    def display_as_owned
      tag.li 'Your the owner of this item', class: 'list-group-item'
      item.active? ? tag.li("Can't Edit an item under active auction", class: 'list-group-item') : tag.li(tag.a("Edit this item", href: edit_item_path(item)), class: 'list-group-item')
    end



    def display_as_active
      tag.li("Status: #{status}", class: 'list-group-item' ) <<
      tag.li("Listed by: #{seller.name}", class: 'list-group-item' ) <<
      tag.li("Auction started at: #{start_time}", class: 'list-group-item')  <<
      tag.li("Auction ends at: #{end_time}", class: 'list-group-item')  <<
      tag.li("Starting price: $#{starting_price}", class: 'list-group-item') <<
      # tag.li("Shipping: $#{shipping}", class: 'list-group-item') <<
      tag.li("Current price: $#{starting_price + current_price}", class: 'list-group-item') 
      # form_with(model: Bid.new, url: item_bids_path(@item), controller: :bid, action: :create) do |f|
      #   # f.hidden_field(:item_id, value: self.id) <<
      #   f.number_field( :amount ) <<
      #   f.submit('Place your bid')
      # end
    end

    def display_as_failed
      tag.li("Status: #{status}", class: 'list-group-item' ) <<
      tag.li("Listed by: #{seller.name}", class: 'list-group-item' ) <<
      tag.li("Auction started at: #{start_time}", class: 'list-group-item')  <<
      tag.li("Auction ended at: #{end_time}", class: 'list-group-item')  <<
      tag.li("Starting price: $#{starting_price}", class: 'list-group-item') <<
      tag.li("Shipping: $#{shipping}", class: 'list-group-item')
    end

    def display_as_pending
      tag.li("Status: #{status}", class: 'list-group-item' ) <<
      tag.li("Listed by: #{seller.name}", class: 'list-group-item' ) <<
      tag.li("Auction starts at: #{start_time}", class: 'list-group-item')  <<
      tag.li("Auction ends at: #{end_time}", class: 'list-group-item')  <<
      tag.li("Starting price: $#{starting_price}", class: 'list-group-item') <<
      tag.li("Shipping: $#{shipping}", class: 'list-group-item')
    end

    def status_based_display 
      update_status
      if sold?
        display_as_sold
      elsif active?
        display_as_active
      elsif failed?
        display_as_failed
      else
        display_as_pending
      end
    end
  end

  module ClassHelper
    # include ActionView::Helpers::TagHelper
    # include ActionView::Helpers::FormHelper
    # include Rails.application.routes.url_helpers

    def dezone(time)
      time.strftime('%Y-%m-%d %H:%M:%S')
    end
  end
end
