# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :authenticate_employee!
  before_action :check_employee, only: %i[edit]

  def show
    render :show, locals: { employee: current_employee }
  end

  def edit
    render :edit, locals: { employee: current_employee }
  end

  def update
    params[:employee].compact_blank! if params[:employee][:email].blank? && params[:employee][:password].blank?
    if current_employee.first_name == 'default' || current_employee.last_name == 'default' \
      || current_employee.first_name.nil? || current_employee.last_name.nil?
      redirect_to edit_employee_path, notice: 'First name and last name cannot be empty.'
    elsif current_employee.update(employee_params)
      redirect_to root_path, notice: 'Your name was successfully added.'
    else
      render :edit, locals: { employee: current_employee }
    end
  end

  def check_employee
    return if current_employee.first_name == 'default' && current_employee.last_name == 'default'

    redirect_to root_path, notice: 'You are not authorized to edit this data.'
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :password)
  end
end
