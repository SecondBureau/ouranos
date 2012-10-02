Refinery::User.class_eval do

    #TODO
    def is_expired?
      false
    end

    #TODO
    def slug
      self.username
    end

end
