class Api::V1::BaseApiController < ApplicationController



protect_from_forgery with: :null_session #CRF対策

def current_user
  @current_user ||= User.first
end

end
