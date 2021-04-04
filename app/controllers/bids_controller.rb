class BidsController < ApplicationController
  def create
    bid = Bid.new amount: params.require(:bid).permit(:amount)
    binding.pry
    
    # if bid.valid?
      

    redirect_to users_path
  end
end
