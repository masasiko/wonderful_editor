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
  context "body,titleが存在している時" do
    it "articleが作られる" do
      article = FactoryBot.build(:article)
      expect(article).to be_valid
    end
  end

  context "bodyが存在しない時" do
    it "articleの作成に失敗する" do
      article = FactoryBot.build(:article, body: nil)
      expect(article).to be_invalid
      # expect(article.errors.details[:body][0][:error]).to eq :blank
    end
  end

  context "titleが存在しない時" do
    it "articleの作成に失敗する" do
      article = FactoryBot.build(:article, title: nil)
      expect(article).to be_invalid
      # expect(article.errors.details[:title][0][:error]).to eq :blank
    end
  end

  context "titleの文字数が30文字以上の時" do
    it "articleの作成に失敗する" do
      article = FactoryBot.build(:article, title: "a" * 31)
      expect(article).to be_invalid
      # expect(article.errors.details[:title][0][:error]).to eq :too_long
    end
  end
end
