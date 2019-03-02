module ApplicationHelper
  require "addressable/uri"

  # return domain name from url
  def domain_name(url)
    uri = Addressable::URI.parse(url)
    return uri.host
  end

  # filter links for advanced search
  def filtered_links
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
    links = Link.where(query).page(params[:page]).per(20)
    links = Link.where(query).where(created_at: params[:from].to_date..params[:to].to_date).page(params[:page]).per(20) if params[:from].present? && params[:to].present?
    links = Link.where(query).where(created_at: params[:from].to_date..Time.now).page(params[:page]).per(20) if params[:from].present? && !params[:to].present?
    links = Link.where(query).where('created_at <= ?',params[:to].to_date).page(params[:page]).per(20) if !params[:from].present? && params[:to].present?
    return links
  end
end
