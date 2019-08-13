class Post < ApplicationRecord

  validates :title, presence: true

  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :post_subs
  has_many :comments
  belongs_to :user
  
end
