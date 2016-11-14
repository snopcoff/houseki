class FdTypesController < ApplicationController
  before_action :set_fd_type, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :authorized_for_admin, only: [:edit, :update, :destroy]

  # GET /fd_types
  # GET /fd_types.json
  def index
    @fd_types = FdType.all
  end

  # GET /fd_types/1
  # GET /fd_types/1.json
  def show
    @fooddrinks = @fd_type.fooddrinks.paginate(page: params[:page], per_page: 9).order(created_at: :asc)
    @fd_types = FdType.all
  end

  # GET /fd_types/new
  def new
    @fd_type = FdType.new
  end

  # GET /fd_types/1/edit
  def edit
  end

  # POST /fd_types
  # POST /fd_types.json
  def create
    @fd_type = FdType.new(fd_type_params)
    notice = 'Successfully add "'+@fd_type.name+'" into category.'
    respond_to do |format|
      if @fd_type.save
        format.html { redirect_to admin_category_url, notice: notice }
        format.json { render :show, status: :created, location: @fd_type }
      else
        format.html { render :new }
        format.json { render json: @fd_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fd_types/1
  # PATCH/PUT /fd_types/1.json
  def update
    respond_to do |format|
      if @fd_type.update(fd_type_params)
        format.html { redirect_to admin_category_url, notice: 'Successfully updated category.' }
        format.json { render :show, status: :ok, location: @fd_type }
      else
        format.html { render :edit }
        format.json { render json: @fd_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fd_types/1
  # DELETE /fd_types/1.json
  def destroy
    notice = '"'+@fd_type.name+'" was successfully removed.'
    @fd_type.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: notice }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fd_type
      @fd_type = FdType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fd_type_params
      params.require(:fd_type).permit(:name, :foodtype)
    end
    
    def authorized_for_admin
      redirect_to root_url unless current_user.has_role? :admin
    end
end
