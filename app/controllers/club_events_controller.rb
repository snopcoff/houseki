class ClubEventsController < ApplicationController
    before_action :find_club
    before_action :set_club_event
    
    def show
    end
    
    def new
        @club_event = ClubEvent.new
    end
    
    def edit
    end
    
    def create
        @club_event = @club.club_events.new(club_event_params)
        
        respond_to do |format|
            
          if @club_event.save
            @club.club_events.first.destroy if @club.club_events.count > 1
            format.html { redirect_to @club, notice: 'Successfully create event.' }
            format.json { head :no_content }
          else
            format.html { redirect_to :back, notice: @club_event.errors[:base] }
            format.json { render json: @club_event.errors[:base], status: :unprocessable_entity }
            ## render json: @club_event.errors, status: :unprocessable_entity
          end
          
        end
        
    end
    
    def update
        respond_to do |format|
            
          if @club_event.update(club_event_params)
            format.html { redirect_to @club, notice: 'Club was successfully updated.' }
            format.json { render :show, status: :ok, location: @club }
          else
            format.html { redirect_to :back, notice: @club_event.errors[:base] }
            format.json { render json: @club_event.errors[:base], status: :unprocessable_entity }
          end
          
        end
        
    end
    
    def destroy
        @club_event.destroy
        
        respond_to do |format|
          format.html { redirect_to @club, notice: 'Club was successfully destroyed.' }
          format.json { head :no_content }
        end
    end
    
    def join_club_event
        
        if current_user.club_events.find_by(club_id: @club_event).presence
          @club_event.users.delete(current_user)
          redirect_to @club, notice: "You will not go to this event."
        else
          @club_event.users << current_user
          redirect_to @club, notice: "You will go to this event."
        end
    end
    
    private
    def club_event_params
        params.require(:club_event).permit(:user_id, :name, :description, :address, :from_date, :to_date)
    end
    
    def find_club
        @club = Club.find(params[:club_id])
    end
    
    def set_club_event
        @club_event = @club.club_events.first
    end
end
