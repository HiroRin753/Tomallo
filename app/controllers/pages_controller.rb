class PagesController < ApplicationController

  def index
   @houses = House.order("created_at DESC").limit(8)
  end

  def serach
  end


end
