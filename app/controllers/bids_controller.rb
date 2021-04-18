class BidsController < ApplicationController
  def create
    @bid = Bid.new params.permit(:item_id).merge params.require(:bid).permit(:amount)
    @bid.user = current_user
    if @bid.valid?
      item = @bid.item
      item.current_price += @bid.amount
      item.update_status
      # item.set_sold if item.sold?
      item.save
      @bid.save
    end
    redirect_to item_path(@bid.item), alert: @bid.errors.full_messages[0]
  end
end
