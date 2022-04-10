require "rails_helper"

RSpec.describe "Api::V1::Auth::Registrations", type: :request do
  describe "POST /api/v1/auth" do
    subject { post(api_v1_user_registration_path, params: params) }

    context "適切なパラメータが送信された時" do
      let(:params) { attributes_for(:user) }
      it "userレコードが作成できる" do
        expect { subject }.to change { User.count }.by(1)
        res = JSON.parse(response.body)
        expect(res["data"]["name"]).to eq params[:name]
        expect(res["data"]["email"]).to eq params[:email]
        expect(response).to have_http_status(:ok)
      end
    end

    context "適切なパラメータが送信された時" do
      let(:params) { attributes_for(:user) }
      it "header情報を取得できる" do
        subject
        expect(response.header["access-token"]).to be_present
        expect(response.header["client"]).to be_present
        expect(response.header["token-type"]).to be_present
        expect(response.header["expiry"]).to be_present
      end
    end

    context " nameが存在しない時" do
      let(:params) { attributes_for(:user, name: nil) }
      it "userレコードが作成されない" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(res["errors"]["name"]).to include("を入力してください")
      end
    end

    context " emailが存在しない時" do
      let(:params) { attributes_for(:user, email: nil) }
      it "userレコードが作成されない" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(res["errors"]["email"]).to include("を入力してください")
      end
    end

    context " passwordが存在しない時" do
      let(:params) { attributes_for(:user, password: nil) }
      it "userレコードが作成されない" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(res["errors"]["password"]).to include("を入力してください")
      end
    end
  end
end
