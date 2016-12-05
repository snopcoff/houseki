class ClubsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :join_club]
  before_action :set_club, only: [:show, :edit, :update, :destroy]
  before_action :get_moderator, only: [:show, :edit, :update, :destroy]

  # GET /clubs
  # GET /clubs.json
  def index
    @clubs = Club.all
  end

  # GET /clubs/1
  # GET /clubs/1.json
  def show
    @club_event = @club.club_events.first
  end

  # GET /clubs/new
  def new
    @club = Club.new
  end

  # GET /clubs/1/edit
  def edit
  end

  # POST /clubs
  # POST /clubs.json
  def create
    @club = Club.new(club_params)

    respond_to do |format|
      if @club.save
        format.html { redirect_to @club, notice: 'Successfully create club.' }
        format.json { render :show, status: :created, location: @club }
        ClubMember.create(:club_id => @club.id, :user_id => current_user.id, :is_moderator => true)
      else
        format.html { render :new }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # PATCH/PUT /clubs/1
  # PATCH/PUT /clubs/1.json
  def update
    respond_to do |format|
      if @club.update(club_params)
        format.html { redirect_to @club, notice: 'Club was successfully updated.' }
        format.json { render :show, status: :ok, location: @club }
      else
        format.html { render :edit }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clubs/1
  # DELETE /clubs/1.json
  def destroy
    @club.destroy
    respond_to do |format|
      format.html { redirect_to clubs_url, notice: 'Club was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def join_club
    club = Club.find(params[:id])
    if current_user.club_members.find_by(club_id: club.id).presence
      ClubMember.find_by(user_id: current_user.id).destroy
      notice = "You have left this club."
    else
      ClubMember.create(club_id: club.id, user_id: current_user.id)
      notice = "You have joined this club."
    end
    
    respond_to do |format|
      format.html { redirect_to club, notice: notice }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club
      @club = Club.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def club_params
      params.require(:club).permit(:name, :club_avatar, :description)
    end
    
    def get_moderator
      @moderator = @club.club_members.find_by(:is_moderator => true).user
    end
end
