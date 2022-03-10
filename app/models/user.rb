# frozen_string_literal: true

class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

has_many :articles, dependent: :destroy
#dependent: :destroyはユーザーが削除されたらarticlesも削除される
has_many :coments, dependent: :destroy
has_many :articles, dependent: :destroy, throuth: :article_like
end
