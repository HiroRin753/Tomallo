require 'rails_helper'

RSpec.describe "reservationcs/edit", type: :view do
  before(:each) do
    @reservationc = assign(:reservationc, Reservationc.create!(
      name: "MyString"
    ))
  end

  it "renders the edit reservationc form" do
    render

    assert_select "form[action=?][method=?]", reservationc_path(@reservationc), "post" do

      assert_select "input[name=?]", "reservationc[name]"
    end
  end
end
