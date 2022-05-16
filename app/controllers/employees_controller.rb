# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :authenticate_employee!

  def show
    render :show, locals: { employee: current_employee }
  end

  def edit
    render :edit, locals: { employee: current_employee }
  end

  def update
    authorize current_employee
    if params[:employee][:first_name].blank? || params[:employee][:last_name].blank?
      redirect_to edit_employee_path, notice: 'First name and last name cannot be empty.'
    elsif current_employee.update(employee_params)
      redirect_to root_path, notice: 'Your name was successfully added.'
    else
      render :edit, locals: { employee: current_employee }
    end
  end

  private

  def employee_params
    params.require(:employee).permit(policy(current_employee).permitted_attributes)
  end
end
