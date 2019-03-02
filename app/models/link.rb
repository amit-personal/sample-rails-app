class Link < ApplicationRecord

  belongs_to :user
  has_many :comments
  has_many :votes

  # where(created_at: (Time.now - 24.hours)..Time.now).order(hot_score: :desc)
  scope :hottest, -> { where(created_at: (Time.now - 24.hours)..Time.now).order(points: :desc) }
  scope :newest, -> { order(created_at: :desc) }

  validates :title,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :url,
            format: { with: %r{\Ahttps?://} },
            allow_blank: true

  def comment_count
    comments.length
  end

  def upvotes
    votes.sum(:upvote)
  end

  def downvotes
    votes.sum(:downvote)
  end

  def calc_hot_score
    points = (1 + (upvotes - downvotes))
    time_ago_in_hours = ((Time.now - created_at) / 3600).round
    score = hot_score_val(points, time_ago_in_hours)

    update_attributes(points: points, hot_score: score)
  end

  def self.api_format
    self.distinct.collect{ |link|
      {
        :id => link.id,
        :title => link.title,
        :points => link.points,
        :username => link.user.username,
        :email => link.user.email,
        :source => domain_name(link.url),
        :url => link.url,
        :time => link.created_at.try(:strftime, "%d %b %Y")
      }
    }
  end

  def self.domain_name(url)
    uri = Addressable::URI.parse(url)
    return uri.host
  end

  private

  def hot_score_val(points, time_ago_in_hours, gravity = 1.8)
    (points - 1) / (time_ago_in_hours + 2) ** gravity
  end

end
