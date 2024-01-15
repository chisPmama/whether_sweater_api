require "rails_helper"

RSpec.describe Restaurant do
  it "exists" do
    data = {:id=>"zXAv5ul5nRJZp3AGq9BzKA",
            :alias=>"broders-pasta-bar-minneapolis",
            :name=>"Broders' Pasta Bar",
            :image_url=>"https://s3-media2.fl.yelpcdn.com/bphoto/bEiPVpgPU5Jge5Yxa0zvrw/o.jpg",
            :is_closed=>false,
            :url=>
            "https://www.yelp.com/biz/broders-pasta-bar-minneapolis?adjust_creative=rBxix910UMNvgaxUVJuRow&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=rBxix910UMNvgaxUVJuRow",
            :review_count=>680,
            :categories=>[{:alias=>"italian", :title=>"Italian"}, {:alias=>"wine_bars", :title=>"Wine Bars"}],
            :rating=>4.5,
            :coordinates=>{:latitude=>44.91208, :longitude=>-93.30902},
            :transactions=>["pickup", "delivery"],
            :price=>"$$",
            :location=>
              {:address1=>"5000 Penn Ave S",
                :address2=>nil,
                :address3=>"",
                :city=>"Minneapolis",
                :zip_code=>"55419",
                :country=>"US",
                :state=>"MN",
                :display_address=>["5000 Penn Ave S", "Minneapolis, MN 55419"]},
            :phone=>"+16129259202",
            :display_phone=>"(612) 925-9202",
            :distance=>8211.65768484225
          }

    restaurant = Restaurant.new(data)

    expect(restaurant).to be_a Restaurant
    expect(restaurant.name).to eq("Broders' Pasta Bar")
    expect(restaurant.address).to eq("5000 Penn Ave S, Minneapolis, MN 55419")
    expect(restaurant.rating).to eq(4.5)
    expect(restaurant.reviews).to eq(680)
  end
end