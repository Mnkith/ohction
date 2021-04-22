class BidsController < ApplicationController
  def create
    @bid = bid_params
    if @bid.valid?
      @bid.save
    end
    redirect_to item_path(@bid.item), alert: @bid.errors.full_messages[0]
  end

  private

  def bid_params
    Bid.new params.permit(:item_id, :amount).merge({user: current_user})
  end
end
