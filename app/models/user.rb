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
has_many :article_like, dependent: :destroy

has_many :coment, dependent: :destroy
end
