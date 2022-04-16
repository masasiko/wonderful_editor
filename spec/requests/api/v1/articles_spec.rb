require "rails_helper"

RSpec.describe "Api::V1::Articles", type: :request do
  describe "GET /api/v1/articles/index" do
    subject { get(api_v1_articles_path) }

    before { create_list(:article, article_count) }

    let(:article_count) { 3 }
    it "記事の一覧が表示される" do
      subject
      Article.all
      res = JSON.parse(response.body)
      expect(res.length).to eq article_count
      expect(res.sort_by {|hash| -hash["created_at"].to_i }).to eq res.sort_by { "created_at" }
      expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
      expect(res[0]["user"].keys).to eq ["id", "name", "email"]
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /api/v1/article/:id" do
    subject { get(api_v1_article_path(article_id)) }

    let(:article_id) { article.id }
    let(:article) { create(:article) }
    it "articleの一覧が表示される" do
      subject
      res = JSON.parse(response.body)
      expect(res["title"]).to eq article.title
      expect(res["body"]).to eq article.body
      expect(res["updated_at"]).to be_present
      expect(res["user"]["id"]).to eq article.user.id
      expect(res["user"].keys).to eq ["id", "name", "email"]
    end
  end

  describe "POST/api/v1/articles" do
    subject { post(api_v1_articles_path, params: params, headers: headers) }

    context "適切なパラメータを送信したとき" do
      let(:params) { { article: attributes_for(:article, user_id: current_ap1_v1_user.id) } }

      let(:current_ap1_v1_user) { create(:user) }
      let(:headers) { current_ap1_v1_user.create_new_auth_token }
      it "記事のレコードを作成できる" do
        expect { subject }.to change { Article.count }.by(1)
        res = JSON.parse(response.body)
        expect(res["title"]).to eq params[:article][:title]
        expect(res["body"]).to eq params[:article][:body]
        expect(res["user"]["id"]).to eq params[:article][:user_id]
      end
    end
  end
  # context "不適切なパラメータを送信した時" do
  # it "レコードが作成できない" do

  # end
  # end

  describe " Patch(PUT) /api/v1/articles/:id" do
    subject { patch(api_v1_article_path(article_id), params: params, headers: headers) }

    let(:params) do
      { article: { title: Faker::Address.city, created_at: 1.day.ago } }
    end
    let(:article_id) { article.id }
    let!(:article) { create(:article, user: current_ap1_v1_user) }
    let!(:current_ap1_v1_user) { create(:user) }
    let!(:headers) { current_ap1_v1_user.create_new_auth_token }
    it "任意のarticleのレコードを更新できる" do
      expect { subject }.to change { Article.find(article_id).title }.from(article.title).to(params[:article][:title]) &
                            not_change { Article.find(article_id).body } &
                            not_change { Article.find(article_id).created_at }
    end
  end

  describe " DELETE /api/v1/articles/:id" do
    subject { delete(api_v1_article_path(article_id), headers: headers) }

    let(:article_id) { article.id }
    let!(:article) { create(:article, user: current_ap1_v1_user) }
    let!(:current_ap1_v1_user) { create(:user) }
    let!(:headers) { current_ap1_v1_user.create_new_auth_token }
    it "任意のarticleのレコードが削除できる" do
      expect { subject }.to change { Article.count }.by(-1)
    end
  end
end
