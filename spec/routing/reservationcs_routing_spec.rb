require "rails_helper"

RSpec.describe ReservationcsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/reservationcs").to route_to("reservationcs#index")
    end

    it "routes to #new" do
      expect(get: "/reservationcs/new").to route_to("reservationcs#new")
    end

    it "routes to #show" do
      expect(get: "/reservationcs/1").to route_to("reservationcs#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/reservationcs/1/edit").to route_to("reservationcs#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/reservationcs").to route_to("reservationcs#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/reservationcs/1").to route_to("reservationcs#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/reservationcs/1").to route_to("reservationcs#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/reservationcs/1").to route_to("reservationcs#destroy", id: "1")
    end
  end
end
