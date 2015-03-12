class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates_presence_of :username
  validates :password, presence: true, on: :create, length: {minimum: 5} #minimum is not working.
  validates_uniqueness_of :username

  sluggable_column :username

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator'
  end

end
