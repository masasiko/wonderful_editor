# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  status     :integer          default(0), not null
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

  context "body,title,statusが存在している時" do
    it "articleが下書きとして保存できる" do
      article = FactoryBot.build(:article, status:0)
      expect(article).to be_valid
      expect(article.status).to eq "draft"
    end

    it "articleが公開として保存できる" do
      article = FactoryBot.build(:article, status:1)


      expect(article).to be_valid
      expect(article.status).to eq "published"
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
      # expect(article.errors.details[:title][0][:error]).to eq :blank
    end
  end
end
