
module Admin
  class CompanyValuesController < AdminController
    def index
        render :index, locals: { company_values: CompanyValue.all }
    end

    def new
        render :new, locals: { company_value: CompanyValue.new }
    end

    def edit
        render :edit, locals: { company_value: company_value }
    end

    def create
      company_value = CompanyValue.new(company_value_params)
      if company_value.save
        redirect_to admin_company_values_path(company_value), notice: 'Company value was successfully created.'
      else
        render :new, locals: { company_value: company_value }
      end
    end

    def update
      if company_value.update(company_value_params)
         redirect_to admin_company_values_path(company_value), notice: 'Company value was successfully updated.'
      else
         render :edit, locals: { company_value: company_value }
      end
    end

    def destroy
        company_value.destroy
        redirect_to admin_company_values_url, notice: 'Company value was successfully destroyed.'
    end

    private

    def company_value
        @company_value = CompanyValue.find(params[:id])
    end

    def company_value_params
        params.require(:company_value).permit(:title)
    end
  end
end
