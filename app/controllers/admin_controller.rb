class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorized_for_admin
  
  def user
    @users = User.all
  end
  
  def fooddrink
    @fooddrinks = Fooddrink.all
  end
  
  def category
    @foods = FdType.where(foodtype: "food")
    @drinks = FdType.where(foodtype: "drink")
  end

  def update_user
    user = User.find(params[:id])
    if user.has_role? :admin
      user.remove_role :admin
      notice = 'Remove admin role from "'+user.name+'" successfully.'
    else
      user.add_role :admin
      notice = 'Set "'+user.name+'" as admin successfully.'
    end
    
    respond_to do |format|
      format.html { redirect_to admin_user_url, notice: notice }
      format.json { head :no_content }
    end
  end
  
  def destroy_user
    user = User.find(params[:id])
    rates = Rate.where(:rater_id => user.id)
    notice = '"'+user.name+'" was successfully removed.'
    fooddrinks = Fooddrink.all
    user.destroy
    rates.delete_all
    
    fooddrinks.each do |fooddrink|
      Fooddrink.update_avg_qty(fooddrink)
      rating_cache = RatingCache.find_by(:cacheable_id => fooddrink.id)
      rating_cache.update_attributes(:avg => fooddrink.avg, :qty => fooddrink.qty) if rating_cache.presence
    end
    
    respond_to do |format|
      format.html { redirect_to admin_user_url, notice: notice }
      format.json { head :no_content }
    end
  end
  
  private
  
  def authorized_for_admin
    redirect_to root_url unless current_user.has_role? :admin
  end
  
end
