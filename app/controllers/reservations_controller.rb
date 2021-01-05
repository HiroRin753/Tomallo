class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = Reservation.all
  end

  def create
    @reservation = Reservation.new(reservation_params)
  end

  def your_trips
      @trips = current_user.reservations.order(start_date: :asc)
  end

  def your_reservations
      @houses = current_user.houses
  end

  private
      def reservations_params
          params.require(:reservation).permit(:start_date, :end_date).merge()
      end



end
