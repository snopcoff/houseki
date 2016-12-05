module ClubsHelper
    
    def is_member(club, user)
        user.club_members.find_by(club_id: club.id).presence ? "Leave Club" : "Join Club"
    end
    
    def can_manage
        (current_user.has_role? :admin) || @club.club_members.find_by(is_moderator: true).user_id == current_user.id
    end
end
