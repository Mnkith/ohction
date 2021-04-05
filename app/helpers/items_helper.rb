module ItemsHelper
  module InstanceHelper
    def started?
      Item.dezone(Time.now) >= Item.dezone(start_time)
    end

    def ended?
      Item.dezone(Time.now) > Item.dezone(end_time)
    end
    
    def sold?
      ended? && (current_price + starting_price) > minimum_price
      # !!self.buyer_id
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

    def owner? current_user
      # binding.pry
      seller_id == current_user.id
    end
    
  end

  

  def status_based_display item
    if item.sold?
      binding.pry
      tag.li('This item is sold', class: 'list-group-item' ) <<
      tag.li("Auction ended at: #{item.end_time}") << 
      tag.li("Item bought by: #{item.buyer.name}")<< 
      tag.li("Item sold for: #{item.current_price + item.starting_price}") 

    elsif item.owner? current_user
      tag.li 'Your the owner of this item', class: 'list-group-item'
      item.active? ? tag.li("Can't Edit an item under active auction", class: 'list-group-item') : tag.li(tag.a("Edit this item", href: edit_item_path(item)), class: 'list-group-item')
    elsif item.active?
      tag.li("Auction started at: #{item.start_time}", class: 'list-group-item')  <<
      tag.li("Auction will end at: #{item.end_time}", class: 'list-group-item')  <<
      tag.li("Starting price: $#{item.starting_price}", class: 'list-group-item') <<
      tag.li("Shipping: $#{item.shipping}", class: 'list-group-item') <<
      tag.li("Current price: $#{item.starting_price + item.current_price}", class: 'list-group-item') <<
      form_with(model: Bid.new) do |f|
        f.hidden_field(:item_id, value: item.id) <<
        f.number_field( :amount ) <<
        f.submit('Place your bid')
      end
    else
      tag.li("Auction will start at: #{item.start_time}", class: 'list-group-item')  <<
      tag.li("Auction will end at: #{item.end_time}", class: 'list-group-item')  <<
      tag.li("Starting price: $#{item.starting_price}", class: 'list-group-item') <<
      tag.li("Shipping: $#{item.shipping}", class: 'list-group-item')

      
    end
  
  end

  module ClassHelper
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
