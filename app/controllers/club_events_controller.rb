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
        
        if @club_event.save
            @club.club_events.first.destroy
            redirect_to @club, notice: 'Successfully create event.'
          else
            redirect_to :back, notice: @club_event.errors[:base][0]
            ## render json: @club_event.errors, status: :unprocessable_entity
        end
    end
    
    def update
        if @club_event.update(club_event_params)
            redirect_to @club, notice: 'Club was successfully updated.'
        else
            redirect_to :back, notice: @club_event.errors[:base][0]
        end
    end
    
    def destroy
        @club_event.destroy
        redirect_to @club, notice: 'Event deleted.'
    end
    
    private
    def club_event_params
        params.require(:club_event).permit(:user_id, :name, :description, :from_date, :to_date)
    end
    
    def find_club
        @club = Club.find(params[:club_id])
    end
    
    def set_club_event
        @club_event = @club.club_events.first
    end
end
