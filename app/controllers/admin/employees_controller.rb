# frozen_string_literal: true

module Admin
  class EmployeesController < AdminController
    def index
      render :index, locals: { employees: Employee.includes(:orders).all }
    end

    def kudos_for_all
      render :add_kudos_for_all, locals: { employees: Employee.all }
    end

    def add_kudos_for_all
      if add_kudos >= 1 && add_kudos <= 20
        Employee.all.each do |employee|
          employee.number_of_available_kudos += add_kudos
          unless employee.save!
            redirect_to kudos_for_all_admin_employees_path,
                        notice: 'There was an error. Please try again.'
          end
        end
        redirect_to admin_employees_path, notice: 'Number of available Kudos was successfully added to Employees.'
      else
        redirect_to kudos_for_all_admin_employees_path, notice: 'Enter a number between 1 and 20.'
      end
    end

    private

    def add_kudos
      params[:add_kudos].to_i
    end
  end
end
