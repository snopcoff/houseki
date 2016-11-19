module StaticPagesHelper
    
    def set_category(ftype, ftype_s)
        action_name.eql?("home") || ftype.eql?(ftype_s)
    end
    
end
