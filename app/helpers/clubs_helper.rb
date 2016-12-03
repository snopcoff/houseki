module ClubsHelper
    
    def is_member(club, user)
        user.club_members.find_by(club_id: club.id).presence ? "Leave Club" : "Join Club"
    end
    
end
