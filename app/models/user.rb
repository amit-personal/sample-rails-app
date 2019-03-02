class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :login

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]

  ## Token Authenticatable
  acts_as_token_authenticatable

  validates :username,
            presence: :true,
            uniqueness: { case_sensitive: false }

  has_many :links
  has_many :comments
  has_many :votes

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def update_password(password, confirm_password)
    @user = user
    unless @user
      @user = User.where("email=?", self.email).first
    end
    @user.update password: password, password_confirmation: confirm_password
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

 	def owns_link?(link)
    self == link.try(:user)
  end

  def owns_comment?(comment)
    self == comment.try(:user)
  end

  def upvote(link)
    votes.create(upvote: 1, link: link)
  end

  def upvoted?(link)
    votes.exists?(upvote: 1, link: link)
  end

  def downvote(link)
    votes.create(downvote: 1, link: link)
  end

  def downvoted?(link)
    votes.exists?(downvote: 1, link: link)
  end

  def remove_vote(link)
    votes.find_by(link: link).destroy
  end

end
