class StaticPagesController < ApplicationController
  def home
    @fooddrinks = Fooddrink.all
    @users = User.all
    
    @fd_types = FdType.all
    
    
    @recommendfood = Fooddrink.where(foodtype: true).order(avg: :desc)
    @recommenddrink = Fooddrink.where(foodtype: false).order(avg: :desc)
  end
  
  def fd_list
    @fd_types = FdType.all
    @fd_type = params[:foodtype]
    redirect_to root_url unless (@fd_type.eql?("food") || @fd_type.eql?("drink"))
    @fdall = Fooddrink.where(foodtype: (@fd_type.eql?("food"))).paginate(page: params[:page], per_page: 9).order(created_at: :desc)
  end
  
end
