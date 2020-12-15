require 'rails_helper'

RSpec.describe "reservationcs/new", type: :view do
  before(:each) do
    assign(:reservationc, Reservationc.new(
      name: "MyString"
    ))
  end

  it "renders new reservationc form" do
    render

    assert_select "form[action=?][method=?]", reservationcs_path, "post" do

      assert_select "input[name=?]", "reservationc[name]"
    end
  end
end
