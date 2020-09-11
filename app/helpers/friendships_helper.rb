module FriendshipsHelper
  def pending_requests_helper(user, current_user)
    namespan = "Name: #{user.name}" + '<span class="profile-link">'
    show_friend = ''
    show_already_friend = ''

    if current_user != User.find(user.id)

      if show_add_friend(user)
        show_friend += link_to('Invite to friendship',
                               { controller: 'friendships', action: 'create', id: user.id },
                               method: :post,
                               class: 'profile-link')
      end

      show_already_friend = '<span> | you are friends</span>' if show_already_friend(user)
    end

    link_to_see = link_to('See profile', user_path(user), class: 'profile-link')

    final_string = namespan + link_to_see + show_friend + show_already_friend

    "<li>#{final_string}</span><li>".html_safe
  end
end
