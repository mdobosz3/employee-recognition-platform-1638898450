class KudosController < ApplicationController
    before_action :set_kudos, only: %i[ show edit update destroy ]
    before_action :authenticate_employee!, except: [:index, :show]
    before_action :correct_employee, only: [:edit, :update, :destroy]

      def index
        render :index, locals: { kudos: Kudo.all }
      #  @kudos = Kudo.all
      end
    
      def show
        render :show, locals: { kudo: kudo }
      end
    
      def new
        render :new, locals: { kudo: Kudo.new }
      end
    
      def edit
      end
    
      def create
        kudo = Kudo.new(kudo_params)
        kudo.giver = current_employee
          if kudo.save
            redirect_to kudos_path, notice: "Kudos was successfully created."
          else
            render :new, locals: { kudo: kudo }
          end
      end
    
      def update
          if kudo.update(kudo_params)
            redirect_to kudos_path, notice: "Kudos was successfully updated."
          else
            render :edit
          end
      end
    
      def destroy
        kudo.destroy
        redirect_to kudos_url, notice: "Kudos was successfully destroyed."

      end
    
    private
      #def set_kudo
      #  @kudos = Kudo.find(params[:id])
      #end
    
      def kudo_params
        params.require(:kudo).permit(:title, :content, :receiver_id)
      end
end

