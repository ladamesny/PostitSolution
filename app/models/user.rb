class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  
  has_secure_password validations: false

  validates_presence_of :username
  validates_presence_of :password, on: :create, length: {minimum: 5} #minimum is not working.
  validates_uniqueness_of :username

  before_save :generate_slug!

def generate_slug!
    the_slug = to_slug(self.username)
    user = User.find_by slug: the_slug
    counter = 2
    while user && user != self
      the_slug = append_suffix(the_slug,counter)
      category = User.find_by slug: the_slug
      counter +=1
    end
    self.slug = str.downcase

  end

  def append_suffix(str, count)
    if str.split("-").last.to_i != 0
      return str.split('-').slice(0...-1).join('-')
    else
      return str + "-" + count.to_s+'-'+ count.to_s
    end
    
  end

  def to_slug(name)
    str = name.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/,"-"
    str.downcase
  end

  def to_param
    self.slug
  end
  

end