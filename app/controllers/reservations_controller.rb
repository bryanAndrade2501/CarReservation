class ReservationsController < ApplicationController
    #before_action :authorize!, except: [:index, :show]
    before_action :protect_pages
    
    def index
        @reservations = Reservation.all
        @user_reservations = Reservation.where(user_id: Current.user.id)
    end

    def new
        @reservation = Reservation.new
        pp params
        @car = Car.find(params[:car_id])
    end

    def show
        @reservation = Reservation.find(params[:id])
    end

    def edit
        @reservation = Reservation.find(params[:id])

    end
      
    def create
        @reservation = Reservation.new(reservation_params)

        if @reservation.save
            redirect_to reservations_path, notice: "Reservation created successfully"
        else
            render :new, status: :unprocessable_entity, alert: "Something went wrong"
        end

    end

    def destroy
        @reservation = Reservation.find(params[:id])
        @reservation.destroy
      
        redirect_to reservations_path, notice: "Reservation deleted successfully"
      end
      

    private

    def reservation_params
        params.require(:reservation).permit( :user_id, :car_id, :pickup_date, :return_date, :total_price, :status)
    end

end