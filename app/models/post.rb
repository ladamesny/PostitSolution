class Post < ActiveRecord::Base
  include Voteable
  include Sluggable

  validates_presence_of :title, :url, :description

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  
  sluggable_column :title

end