module PostsHelper
  def render_text_section(post)
    content_tag(:div, class: 'text') do
      concat content_tag(:p, "Comments: #{post.comments_counter.nil? ? 0 : post.comments_counter}",
                         class: 'comment-text')
      concat link_to 'Likes: ', increment_likes_path(post), method: :post, remote: true, class: 'like-counter',
                                                            id: "like-link-#{post.id}"
      concat content_tag(:span, post.likes_counter.nil? ? 0 : post.likes_counter, class: 'like-counter-number',
                                                                                  id: "like-counter-#{post.id}")
    end
  end

  def render_comments_section(post)
    content_tag(:ul, class: 'posts-helper-cont') do
      concat content_tag(:h4, 'Comments:', class: 'posts-helper-comments')

      if post.comments.blank?
        concat content_tag(:li, 'no comments yet...', class: 'posts-helper-comment')
      else
        post.recent_comments.each do |comment|
          concat content_tag(:li, "#{User.find(comment.author_id).name}: #{comment.text.downcase}",
                             class: 'posts-helper-comment')
        end
      end
    end
  end
end
