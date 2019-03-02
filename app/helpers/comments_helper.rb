module CommentsHelper
  def comments_tree_for(comments)
    comments.map do |comment, nested_comments|
      render(comment) +
        (nested_comments.size > 0 ? content_tag(:div, comments_tree_for(nested_comments), class: "replies") : nil)
    end.join.html_safe
  end

  def thread_for(comments)
    comments.map do |thread, nested_comments|
      render(:template =>"comments/_thread.html.erb", :layout => nil , :locals => { :thread => thread }).to_s +
        (nested_comments.size > 0 ? content_tag(:div, comments_tree_for(nested_comments), class: "replies") : nil)
    end.join.html_safe
  end

  # filter comments for advanced search
  def filtered_comments
    case params[:contains]
    when '0'
      query = "LOWER(title) LIKE ('%" + params[:q].downcase + "%') or LOWER(description) LIKE ('%" + params[:q].downcase + "%') or LOWER(url) LIKE ('%" + params[:q].downcase + "%')"
    when '1'
      query = "LOWER(title) = '" + params[:q].downcase + "' or LOWER(description) = '" + params[:q].downcase + "' or LOWER(url) = '" + params[:q].downcase + "'"
    when '2'
      query = "LOWER(title) LIKE ('" + params[:q].downcase + "%') or LOWER(description) LIKE ('" + params[:q].downcase + "%') or LOWER(url) LIKE ('" + params[:q].downcase + "%')"
    when '3'
      query = "LOWER(title) LIKE ('%" + params[:q].downcase + "') or LOWER(description) LIKE ('%" + params[:q].downcase + "') or LOWER(url) LIKE ('%" + params[:q].downcase + "')"
    end
    link_ids = Link.where(query).map {|comment| comment.id}
    link_ids = Link.where(query).where(created_at: params[:from].to_date..params[:to].to_date).map {|comment| comment.id} if params[:from].present? && params[:to].present?
    link_ids = Link.where(query).where(created_at: params[:from].to_date..Time.now).map {|comment| comment.id} if params[:from].present? && !params[:to].present?
    link_ids = Link.where(query).where('created_at <= ?',params[:to].to_date).map {|comment| comment.id} if !params[:from].present? && params[:to].present?
    comments = Comment.where(parent_id: nil, link_id: link_ids).page(params[:page]).per(20)
    return comments
  end
end
