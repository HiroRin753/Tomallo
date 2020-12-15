require 'rails_helper'

RSpec.describe "reservationcs/show", type: :view do
  before(:each) do
    @reservationc = assign(:reservationc, Reservationc.create!(
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
