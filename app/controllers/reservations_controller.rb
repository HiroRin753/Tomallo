class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = Reservation.all
  end

  def new
    @reservarion = Reservation.new
  end

  def create
    @house = House.find(params[:id])
    @reservation = Reservation.new(reservation_params)
    respond_to do |format|
        if preservation.save
            format.html{ redirect_to @reservation, notice: '予約が完了しました。'}
            format.json { render :show, status: :created, location: @reservation}
        else
          format.html { render :new }
          format.json { render json: @reservation.errors, status: :unprocessable_entity }
        end
      end
  end

  def your_trips
      @trips = current_user.reservations.order(start_date: :asc)
  end

  def your_reservations
      @houses = current_user.houses
  end

  private
      def reservations_params
          params.require(:reservation).permit(:start_date, :end_date, :price, :total).merge(use_id: current_user.id, house_id: @house.id)
      end
end
