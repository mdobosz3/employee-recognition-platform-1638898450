module Admin
  class PagesController < AdminController
    before_action :authenticate_admin_user!
    def dashboard; end
  end
end
