class Article < ApplicationRecord
  belongs_to :user
  has_many :users, dependent: :destroy, throuth: :article_like
end
