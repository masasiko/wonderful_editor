class Auth::RegistrationsController < ApplicationController

  before_action :authenticate_user!


  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    binding.pry
    before_action :authenticate_user!

    def members_only
      render json: {
        data: {
          message: "Welcome #{current_user.name}",
          user: current_user
        }
      }, status: 200
    end

end
