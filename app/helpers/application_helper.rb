module ApplicationHelper
    
    # Returns the full title on a per-page basis.
    def full_title(page_title='')
        base_title = "Foods and Drinks Review"
        if page_title.empty?
            base_title
        else
            page_title + " | " + base_title
        end
    end
    
    def display_info(fooddrink)
        "<p><b>#{fooddrink.name}</b></p>
        <p>Place: #{fooddrink.address}</p>
        <p>Type: #{fooddrink.fd_type.name}</p>
        <p>Price: #{fooddrink.price} #{fooddrink.price_unit}</p>
        <p>#{truncate(fooddrink.review, length: 30)}</p>
        <p>By <i>#{fooddrink.user.name}</i></p>"
    end
    
    def user_avatar(user)
        return user.avatar_url if user.avatar?
        "default_avatar.png"
    end
    
end
