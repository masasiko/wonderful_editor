require "rails_helper"

RSpec.describe "Api::V1::Current::Articles", type: :request do
  describe "GET /api/v1/current/article" do

    # index正常系
    subject { get(api_v1_current_articles_path, headers: headers) }

    context "ログイン状態で記事のstatusがpublishedの場合" do
      let!(:article) { create_list(:article, article_count, user: current_ap1_v1_user, status: 1) }
      let(:article_count) { 3 }
      let(:article_id) { article.id }
      let(:current_ap1_v1_user) { create(:user) }
      let(:headers) { current_ap1_v1_user.create_new_auth_token }
      let!(:article_a) { create(:article, status: 1) }
      it "ログインしているユーザーの公開記事一覧を表示できる" do
        subject
        res = JSON.parse(response.body)
        expect(res.length).to eq article_count
        expect(res.sort_by {|hash| -hash["created_at"].to_i }).to eq res.sort_by { "created_at" }
        expect(res[0]["status"]).to eq "published"
        expect(res[0].keys).to eq ["id", "title", "status", "updated_at", "user"]
        expect(res[0]["user"].keys).to eq ["id", "provider", "uid", "allow_password_change", "name", "nickname", "image", "email", "created_at", "updated_at"]
        expect(response).to have_http_status(:ok)
      end
    end

    # index異常系
    context "ログイン状態で記事のstatusが下書き記事のみ場合" do
      let!(:article) { create_list(:article, article_count, user: current_ap1_v1_user, status: 0) }
      let(:article_count) { 3 }
      let(:article_id) { article.id }
      let!(:current_ap1_v1_user) { create(:user) }
      let(:headers) { current_ap1_v1_user.create_new_auth_token }
      fit "ログインしているユーザーの公開一覧を表示されない" do
        subject
        res = JSON.parse(response.body)
        expect(res).to eq []
      end
    end
  end

  describe "GET /api/v1/current/articles/:id" do
    subject { get(api_v1_current_article_path(article_id), headers: headers) }

    # show正常系
    context "ログインユーザの記事が公開記事の場合" do
      let!(:article) { create(:article, user: current_ap1_v1_user, status: 1) }
      let(:article_id) { article.id }
      let!(:current_ap1_v1_user) { create(:user) }
      let(:headers) { current_ap1_v1_user.create_new_auth_token }
      it "指定された記事が表示される" do
        subject
        res = JSON.parse(response.body)
        expect(article.status).to eq "published"
        expect(res["title"]).to eq article.title
        expect(res["body"]).to eq article.body
        expect(res["updated_at"]).to be_present
        expect(res["user"]["id"]).to eq article.user.id
        expect(res["user"].keys).to eq ["id", "name", "email"]
      end
    end

    # show異常系
    context "指定された記事がログインユーザー以外の場合" do
      let!(:article) { create(:article, status: 1) }
      let(:article_id) { article.id }
      let!(:current_ap1_v1_user) { create(:user) }
      let(:headers) { current_ap1_v1_user.create_new_auth_token }
      it "指定された記事が表示されない" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
