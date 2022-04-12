require 'rails_helper'

RSpec.describe "Api::V1::Auth::Sessions", type: :request do
  describe "POST /api/v1/auth/sign_in" do
    subject { post(api_v1_user_session_path, params: params,headers: headers) }

    context "適切なパラメータが送信された時" do
      let!(:params) {{ email: user.email, password:user.password }}
      let!(:user){create(:user)}
        fit "ログインできる" do
          subject
          res = JSON.parse(response.body)
          expect(res["data"]["email"]).to eq params[:email]
          expect(res["data"]["name"]).to eq(user.name)
          expect(response.header["access-token"]).to be_present
          expect(response.header["client"]).to be_present
          expect(response.header["token-type"]).to be_present
          expect(response.header["expiry"]).to be_present
        end
      end

    context "不適切なパラメータが送信された時" do
      let!(:params) {{ email: user.email, password:nil }}
      let!(:user){create(:user)}
        it"ログインエラー"do
          subject
          res = JSON.parse(response.body)
          expect(res["errors"]).to include("ログイン用の認証情報が正しくありません。再度お試しください。")
          expect(response.header["access-token"]).not_to be_present
          expect(response.header["client"]).not_to be_present
          expect(response.header["token-type"]).not_to be_present
          expect(response.header["expiry"]).not_to be_present
      end
     end
    end

    describe "DELETE /api/v1/auth/sign_out" do
      subject { delete(destroy_api_v1_user_session_path ,headers: headers) }

      let(:user){create(:user)}
      let(:headers) { user.create_new_auth_token }

      it"ログアウトできる"do
      subject
      expect(user.tokens).to be_blank
      expect(response).to have_http_status(:ok)
      binding.pry
        end
    end

  end
