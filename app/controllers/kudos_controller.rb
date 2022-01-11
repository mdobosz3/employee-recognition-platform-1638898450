# frozen_string_literal: true

class KudosController < ApplicationController
  before_action :authenticate_employee!

  def index
    render :index, locals: { kudos: Kudo.all }
  end

  def new
    render :new, locals: { kudo: Kudo.new }
  end

  def create
    kudo = Kudo.new(kudo_params)
    kudo.giver = current_employee
    if kudo.save
      redirect_to kudos_path, notice: 'Kudos was successfully created.'
    else
      render :new, locals: { kudo: kudo }
    end
  end

  private

  def kudo_params
    params.require(:kudo).permit(:title, :content, :receiver_id)
  end
end
