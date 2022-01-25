module Admin
  class KudosController < AdminController

    # GET /admin/kudos
    def index
      render :index, locals: { kudos: Kudo.all }
    end

    # GET /admin/kudos/1
    def show
      render :show, locals: { kudo: kudo }
    end

    # GET /admin/kudos/new
    def new
      render :new, locals: { kudo: Kudo.new }
    end

    # GET /admin/kudos/1/edit
    def edit
      render :edit, locals: { kudo: kudo }
    end

    # POST /admin/kudos
    def create
      kudo = Kudo.new(kudo_params)
      if kudo.save
        redirect_to admin_kudo_path(kudo), notice: 'Kudo was successfully created.'
      else
        render :new, locals: { kudo: kudo }
      end
    end

    # PATCH/PUT /admin/kudos/1
    def update
      if kudo.update(kudo_params)
        redirect_to admin_kudo_path(kudo), notice: 'Kudo was successfully updated.'
      else
        render :edit, locals: { kudo: kudo }
      end
    end

    # DELETE /admin/kudos/1
    def destroy
      kudo.destroy
      redirect_to admin_kudos_url, notice: 'Kudo was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def kudo
        @kudo = Kudo.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def kudo_params
        params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id)
      end
  end
end
