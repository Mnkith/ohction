class BidsController < ApplicationController
  def create
    @bid = Bid.new params.require(:bid).permit(:amount, :item_id)
    @bid.user = current_user
    # @bid.valid?
    # binding.pry
    
    if @bid.valid?
      item = @bid.item
      item.current_price += @bid.amount
      binding.pry
      item.buyer = current_user if item.sold?
      item.save
      @bid.save
      # redirect_to item_path(item)
    end
    
    redirect_to item_path(@bid.item)
  end
end
