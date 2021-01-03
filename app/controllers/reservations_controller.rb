class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
      house = House.find(params[:house_id])

      if current_user == house.user
          flash[:alert] = "You cannot book your own room!"
      else
          start_date = Date.parse(reservations_params[:start_date])
          end_date = Date.parse(reservations_params[:end_date])
          days = (end_date - start_date).to_i + 1

          @reservation = current_user.reservations.build(reservations_params)
          @reservation.room = house
          @reservation.price = house.price
          @reservation.total = house.price * days
          @reservation.save

          flash[:notice] = "Booked Successfully!"
      end
      redirect_to room
  end

  def your_trips
      @trips = current_user.reservations.order(start_date: :asc)
  end

  def your_reservations
      @houses = current_user.houses
  end

  private
      def reservations_params
          params.require(:reservation).permit(:start_date, :end_date)
      end

end
