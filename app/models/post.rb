class Post < ActiveRecord::Base
  validates_presence_of :title, :url, :description

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  before_save :generate_slug!

  def total_votes
    self.up_votes - self.down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end

def generate_slug!
    the_slug = to_slug(self.title)
    post = Post.find_by slug: the_slug
    counter = 2
    while psot && post != self
      the_slug = append_suffix(the_slug,counter)
      category = Post.find_by slug: the_slug
      counter +=1
    end
    self.slug = the_slug

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