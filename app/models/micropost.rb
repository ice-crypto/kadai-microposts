class Micropost < ApplicationRecord
  belongs_to :user
  
  has_many :favorites
  has_many :likers, through: :favorites, source: :micropost
  
  validates :content, presence: true, length: { maximum: 255 }
  
end
