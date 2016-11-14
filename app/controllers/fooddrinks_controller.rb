class FooddrinksController < ApplicationController
  before_action :set_fooddrink, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :load_category
  
  load_and_authorize_resource

  # GET /fooddrinks
  # GET /fooddrinks.json
  def index
    @results = @search.result.paginate(page: params[:page], per_page: 9).order(created_at: :desc)
  end

  # GET /fooddrinks/1
  # GET /fooddrinks/1.json
  def show
    @fooddrinks = Fooddrink.all
    Fooddrink.update_avg_qty(@fooddrink)
    @recommends = Fooddrink.where(user_id: @fooddrink.user_id).where.not(id: @fooddrink.id).order(created_at: :desc)
  end

  # GET /fooddrinks/new
  def new
    @fooddrink = Fooddrink.new
  end

  # GET /fooddrinks/1/edit
  def edit
  end

  # POST /fooddrinks
  # POST /fooddrinks.json
  def create
    @fooddrink = Fooddrink.new(fooddrink_params)
    @fooddrink.user_id = current_user.id

    respond_to do |format|
      if @fooddrink.save
        format.html { redirect_to @fooddrink, notice: 'Fooddrink was successfully created.' }
        format.json { render :show, status: :created, location: @fooddrink }
      else
        format.html { render :new }
        format.json { render json: @fooddrink.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fooddrinks/1
  # PATCH/PUT /fooddrinks/1.json
  def update
    respond_to do |format|
      if @fooddrink.update(fooddrink_params)
        format.html { redirect_to @fooddrink, notice: 'Fooddrink was successfully updated.' }
        format.json { render :show, status: :ok, location: @fooddrink }
      else
        format.html { render :edit }
        format.json { render json: @fooddrink.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fooddrinks/1
  # DELETE /fooddrinks/1.json
  def destroy
    @fooddrink.destroy
    if request.referrer.eql?(request.base_url+"/admin/fooddrink")
      redirect_url = :back
    else
      redirect_url = root_url
    end
    
    respond_to do |format|
      format.html { redirect_to redirect_url, notice: 'Fooddrink was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  protected
    # Use callbacks to share common setup or constraints between actions.
    def set_fooddrink
      @fooddrink = Fooddrink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fooddrink_params
      params.require(:fooddrink).permit(:user_id, :name, :address, :foodtype, :file, :created_at, :price, :price_unit, :review, :fd_type_id, :avg, :qty)
    end
    
    def load_category
      @categories = FdType.all
    end

=begin    
    def update_avg_qty
      sum = 0
      qty = 0
      
      @fooddrink.rates('overall').each do |rate|
        sum += rate
        qty += 1
      end
      
      @fooddrink.avg = sum/qty.to_f
      @fooddrink.qty = qty
      @fooddrink.save!
    end
=end

end
