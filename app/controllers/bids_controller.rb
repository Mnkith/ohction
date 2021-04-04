class BidsController < ApplicationController
  def create
    @bid = Bid.new params.require(:bid).permit(:amount, :item_id)
    @bid.user = current_user
    # @bid.valid?
    # binding.pry
    
    if @bid.valid?

    end

      

    redirect_to item_path(@bid.item)
  end
end
