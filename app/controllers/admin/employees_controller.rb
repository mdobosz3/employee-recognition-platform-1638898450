# frozen_string_literal: true

module Admin
  class EmployeesController < AdminController
    def index
      render :index, locals: { employees: Employee.includes(:orders).all }
    end

    def edit
      render :edit, locals: { employee: employee }
    end

    def update
      params[:employee].compact_blank! if params[:employee][:password].blank?
      if employee.update(employee_params)
        redirect_to admin_employees_path, notice: 'Employee was successfully updated.'
      else
        render :edit, locals: { employee: employee }
      end
    end

    def destroy
      employee.destroy
      redirect_to admin_employees_path, notice: 'Employee was successfully destroyed.'
    end

    def edit_kudos_for_all
      render :update_kudos_for_all, locals: { employees: Employee.all }
    end

    def update_kudos_for_all
      if add_kudos_param >= 1 && add_kudos_param <= 20

        begin
          ActiveRecord::Base.transaction do
            Employee.find_each do |employee|
              employee.number_of_available_kudos += add_kudos_param
              employee.save!
            end
          end
        rescue ActiveRecord::RecordNotSaved => e
          render :new, notice: "Something go wrong. Please try again. #{e.message}"
        end

        redirect_to admin_employees_path, notice: 'Number of available Kudos was successfully added to Employees.'
      else
        redirect_to edit_kudos_for_all_admin_employees_path, notice: 'Enter a number between 1 and 20.'
      end
    end

    private

    def employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :email, :password, :number_of_available_kudos)
    end

    def add_kudos_param
      params[:add_kudos].to_i
    end
  end
end
