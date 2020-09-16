module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def posts_errors
    message = ''
    if @post.errors.full_messages.any?
      message = '<p class="errors">'
      message += "Post could not be saved. #{@post.errors.full_messages.join('. ')}"
      message += '</p>'
    end
    message.html_safe
  end

  def show_add_friend(user)
    return unless !current_user.friend?(user) &&
                  !current_user.pending_friend?(user) && current_user != User.find(user.id)

    link_to('Invite to friendship', { controller: 'friendships', action: 'create', id: user.id },
            method: :post, class: 'profile-link')
  end

  def show_already_friend(user)
    '<span> | you are friends</span>'.html_safe if current_user.friend?(user) && current_user != User.find(user.id)
  end
end
