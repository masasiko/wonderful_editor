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
require "rails_helper"

RSpec.describe Article, type: :model do


    context "bode,titleが存在している時" do
     fit "articleが作られる" do
        user = FactoryBot.create(:user)
        article= FactoryBot.build(:article, user_id:1)
        expect(article).to be_invalid
binding.pry
     end
    end





end
