class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = Reservation.all
  end

  def new
    @reservation = Reservation.new
    @house = House.find(params[:house_id])
  end

  def create
    
    house = House.find(params[:house_id])

        if current_user == house.user
            flash[:alert] = "ご自身のお部屋は予約できません。"
        else
            start_date = Date.parse(reservations_params[:start_date])
            end_date = Date.parse(reservations_params[:end_date])
            days = (end_date - start_date).to_i + 1

            @reservation = current_user.reservations.build(reservations_params)
            @reservation.house = house
            @reservation.price = house.price
            @reservation.total = house.price * days
            @reservation.save

            flash[:notice] = "予約が完了しました!"
        end
        redirect_to room
  end


  def preload
    today = Date.today
    reservations = @house.reservations.where("start_date >= ? OR end_date >= ?", today, today)

    render json: reservations
  end

  def preview
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])

    output = {
      conflict: is_conflict(start_date, end_date, @house)
    }

    render json: output
  end

  private

    def your_trips
       @trips = current_user.reservations.order(start_date: :asc)
    end

    def your_reservations
       @houses = current_user.houses
    end

  
    def reservations_params
        params.require(:reservation).permit(:start_date, :end_date)
    end

      def is_conflict(start_date, end_date, house)
        check = house.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
        check.size > 0? true : false
      end
end

