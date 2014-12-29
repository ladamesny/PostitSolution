class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  
  has_secure_password validations: false

  validates_presence_of :username
  validates_presence_of :password, on: :create, length: {minimum: 5} #minimum is not working.
  validates_uniqueness_of :username

  before_save :generate_slug

  def generate_slug
    self.slug = self.username.gsub(" ", "-").downcase
  end

  def to_param
    self.slug
  end
  

end