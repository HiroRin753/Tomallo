require 'rails_helper'

RSpec.describe "reservationcs/index", type: :view do
  before(:each) do
    assign(:reservationcs, [
      Reservationc.create!(
        name: "Name"
      ),
      Reservationc.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of reservationcs" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
