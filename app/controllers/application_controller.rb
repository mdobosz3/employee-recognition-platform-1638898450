# frozen_string_literal: true

class ApplicationController < ActionController::Base
    include Pundit::Authorization

    def pundit_user
        current_employee
    end

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private
  
    def user_not_authorized
      redirect_to kudos_path, notice: 'You can no longer edit or delete this kudo.'
    end
end
