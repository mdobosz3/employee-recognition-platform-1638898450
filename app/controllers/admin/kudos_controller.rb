# frozen_string_literal: true

module Admin
  class KudosController < AdminController
    def index
      render :index, locals: { kudos: Kudo.includes(:company_value).all }
    end

    def show
      render :show, locals: { kudo: kudo }
    end

    def new
      render :new, locals: { kudo: Kudo.new }
    end

    def edit
      render :edit, locals: { kudo: kudo }
    end

    def create
      kudo = Kudo.new(kudo_params)
      if kudo.save
        redirect_to admin_kudo_path(kudo), notice: 'Kudo was successfully created.'
      else
        render :new, locals: { kudo: kudo }
      end
    end

    def update
      if kudo.update(kudo_params)
        redirect_to admin_kudo_path(kudo), notice: 'Kudo was successfully updated.'
      else
        render :edit, locals: { kudo: kudo }
      end
    end

    def destroy
      kudo.destroy
      redirect_to admin_kudos_url, notice: 'Kudo was successfully destroyed.'
    end

    private

    def kudo
      @kudo = Kudo.find(params[:id])
    end

    def kudo_params
      params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id, :company_value_id)
    end
  end
end
