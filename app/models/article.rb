class Article < ApplicationRecord
  belongs_to :user
  has_many :article_like, dependent: :destroy

  has_many :coment, dependent: :destroy
end
