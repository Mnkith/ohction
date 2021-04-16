class BidsController < ApplicationController
  def create

    # binding.pry
    @bid = Bid.new params.permit( :item_id).merge params.require(:bid).permit(:amount)
    @bid.user = current_user
    # binding.pry
    if @bid.valid?
      item = @bid.item
      item.current_price += @bid.amount
      # binding.pry
      item.set_sold if item.sold?
      item.save
      @bid.save
      # redirect_to item_path(item)
    end
    redirect_to item_path(@bid.item), alert: @bid.errors.full_messages[0]
  end

end
