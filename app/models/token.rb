class Token < ActiveRecord::Base
  belongs_to :user

  before_validation :generate_token, on: :create

  validates_presence_of :user, :token

  scope :with_user, -> (id) { where(user_id: id) }
  scope :with_token, -> (token) { where(token: token) }
  scope :available, -> { where("expire_at > ? and is_used = ?", DateTime.now, false) }

  class << self
    def verify(token)
      with_token(token).available.any?
    end

    def for_user(user)
      token = find_or_create_by(user_id: user.id, is_used: false)

      if token.expired?
        token = create(user_id: user.id)
      end

      token
    end
  end

  def to_param
    self.token
  end

  def expired?
    expires_at <= Time.now
  end

  def confirm!
    self.update is_used: true
  end

  def valid_for_confirmation?
    !is_used  && !expired?
  end

  private

  def generate_token
    self.token = SecureRandom.hex(16)
    self.expire_at = 30.minutes.from_now
  end
end
