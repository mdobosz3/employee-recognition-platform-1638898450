# frozen_string_literal: true

module Admin
  class EmployeesController < AdminController
    def index
      render :index, locals: { employees: Employee.includes(:orders).all }
    end

    def edit_kudos_for_all
      render :update_kudos_for_all, locals: { employees: Employee.all }
    end

    def update_kudos_for_all
      if add_kudos_param >= 1 && add_kudos_param <= 20
        Employee.all.each do |employee|
          employee.number_of_available_kudos += add_kudos_param
          unless employee.save!
            redirect_to edit_kudos_for_all_admin_employees_path,
                        notice: 'There was an error. Please try again.'
          end
        end
        redirect_to admin_employees_path, notice: 'Number of available Kudos was successfully added to Employees.'
      else
        redirect_to edit_kudos_for_all_admin_employees_path, notice: 'Enter a number between 1 and 20.'
      end
    end

    private

    def add_kudos_param
      params[:add_kudos].to_i
    end
  end
end
