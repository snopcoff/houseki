module ClubsHelper
    
    def is_member
        current_user.club_members.find_by(club_id: @club.id).presence ? "Leave Club" : "Join Club"
    end
    
    def can_manage
        (current_user.has_role? :admin) || @club.club_members.find_by(is_moderator: true).user_id == current_user.id
    end
    
    def can_view
        is_member || can_manage
    end
end
