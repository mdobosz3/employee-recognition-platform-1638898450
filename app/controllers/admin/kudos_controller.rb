class Admin::KudosController < ApplicationController
  before_action :set_admin_kudo, only: [:show, :edit, :update, :destroy]

  # GET /admin/kudos
  def index
    @admin_kudos = Admin::Kudo.all
  end

  # GET /admin/kudos/1
  def show
  end

  # GET /admin/kudos/new
  def new
    @admin_kudo = Admin::Kudo.new
  end

  # GET /admin/kudos/1/edit
  def edit
  end

  # POST /admin/kudos
  def create
    @admin_kudo = Admin::Kudo.new(admin_kudo_params)

    if @admin_kudo.save
      redirect_to @admin_kudo, notice: 'Kudo was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/kudos/1
  def update
    if @admin_kudo.update(admin_kudo_params)
      redirect_to @admin_kudo, notice: 'Kudo was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/kudos/1
  def destroy
    @admin_kudo.destroy
    redirect_to admin_kudos_url, notice: 'Kudo was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_kudo
      @admin_kudo = Admin::Kudo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_kudo_params
      params.fetch(:admin_kudo, {})
    end
end
