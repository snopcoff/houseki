json.extract! club_event, :id, :club_id, :user_id, :name, :description, :from_date, :to_date, :created_at, :updated_at
json.url club_club_event_url(club_event, format: :json)