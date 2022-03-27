# frozen_string_literal: true

module Admin
  class EmployeesController < AdminController
    def index
      render :index, locals: { employees: Employee.includes(:orders).all }
    end

    def kudos_for_all
      render :add_kudos_for_all, locals: { employees: Employee }
    end

    def add_kudos_for_all
      Employee.all.each do |employee|
        employee.number_of_available_kudos += add_kudos
        redirect_to admin_employee_kudos_for_all_path(Employee), notice: 'There was an error. Please try again.' unless employee.save!
      end
      redirect_to admin_employees_path, notice: 'Number of available Kudos was successfully added to Employees.'
    end

    private

    def add_kudos
      params[:add_kudos].to_i
    end
  end
end
