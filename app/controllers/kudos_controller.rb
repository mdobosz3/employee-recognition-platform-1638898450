# frozen_string_literal: true

class KudosController < ApplicationController
  before_action :authenticate_employee!
  before_action :check_kudo_giver, only: %i[edit update destroy]

  def index
    render :index, locals: { kudos: Kudo.includes(:company_value, :giver, :receiver).all }
  end

  def show
    render :show, locals: { kudo: kudo }
  end

  def new
    if current_employee.number_of_available_kudos < 1
      redirect_to kudos_path, notice: 'You have no kudos available to give.'
    else
      render :new, locals: { kudo: Kudo.new }
    end
  end

  def edit
    render :edit, locals: { kudo: kudo }
  end

  def create
    redirect_to kudos_path, notice: 'You have no kudos available to give.' unless current_employee.number_of_available_kudos > 1
    kudo = Kudo.new(kudo_params)
    kudo.giver = current_employee
    if kudo.save
      current_employee.number_of_available_kudos -= 1
      current_employee.save
      redirect_to kudos_path, notice: 'Kudos was successfully created.'
    else
      render :new, locals: { kudo: kudo }
    end
  end

  def update
    if kudo.update(kudo_params)
      redirect_to kudos_path, notice: 'Kudos was successfully updated.'
    else
      render :edit, locals: { kudo: kudo }
    end
  end

  def destroy
    kudo.destroy
    redirect_to kudos_url, notice: 'Kudos was successfully destroyed.'
  end

  def check_kudo_giver
    redirect_to kudos_path, notice: 'You are not authorized to edit this kudo.' unless kudo.giver == current_employee
  end

  private

  def kudo_params
    params.require(:kudo).permit(:title, :content, :receiver_id, :company_value_id)
  end

  def kudo
    @kudo = Kudo.find(params[:id])
  end
end
