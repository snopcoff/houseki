class FdTypesController < ApplicationController
  before_action :set_fd_type, only: [:show, :edit, :update, :destroy]

  # GET /fd_types
  # GET /fd_types.json
  def index
    @fd_types = FdType.all
  end

  # GET /fd_types/1
  # GET /fd_types/1.json
  def show
     @fooddrinks = Fooddrink.all
    @users = User.all
    
    @fd_type = FdType.find(params[:id])
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

    respond_to do |format|
      if @fd_type.save
        format.html { redirect_to @fd_type, notice: 'Fd type was successfully created.' }
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
        format.html { redirect_to @fd_type, notice: 'Fd type was successfully updated.' }
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
    @fd_type.destroy
    respond_to do |format|
      format.html { redirect_to fd_types_url, notice: 'Fd type was successfully destroyed.' }
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
end
