# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Article < ApplicationRecord
   validates_presence_of :body, :title
   validates  :title, length: {maximum: 30 }



  belongs_to :user
  has_many :article_like, dependent: :destroy
  has_many :coment, dependent: :destroy
end
