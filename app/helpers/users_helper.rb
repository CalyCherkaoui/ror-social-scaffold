module UsersHelper
    def show_add_friend(user)
        !current_user.friend?(user) && !current_user.pending_friend?(user)
    end

    def show_already_friend(user)
        current_user.friend?(user)
    end
end
