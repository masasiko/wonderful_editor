# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  image                  :string
#  name                   :string
#  nickname               :string
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  context "name を指定しているとき" do
    it "ユーザーが作られる" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
  end

  context "name を指定していないとき" do
    it "ユーザー作成に失敗する" do
      user = FactoryBot.build(:user, name: nil)
      expect(user).to be_invalid
      # expect(user.errors.details[:name][0][:error]).to eq :blank
    end
  end

  context "すでに同じnameが存在するとき" do
    before { create(:user, name: "bar") }

    it "ユーザー作成に失敗する" do
      user = FactoryBot.build(:user, name: "bar")

      expect(user).to be_invalid
      # expect(user.errors.details[:name][0][:error]).to eq :taken
    end
  end

  context "nameのみ入力" do
    let(:user) { build(:user, email: nil, password: nil) }
    it "ユーザー作成に失敗する" do
      expect(user).to be_invalid
      # expect(user.errors.details[:password][0][:error]).to eq :blank
      # expect(user.errors.details[:email][0][:error]).to eq :blank
    end
  end

  context "emailがない場合" do
    let(:user) { build(:user, email: nil) }
    it "ユーザー作成に失敗する" do
      expect(user).to be_invalid
      # expect(user.errors.details[:email][0][:error]).to eq :blank
    end
  end

  context "passwordがない場合" do
    let(:user) { build(:user, password: nil) }
    it "ユーザー作成に失敗する" do
      expect(user).to be_invalid
      #  expect(user.errors.details[:password][0][:error]).to eq :blank
    end
  end
end
