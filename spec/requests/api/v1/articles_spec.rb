require 'rails_helper'


RSpec.describe "Api::V1::Articles", type: :request do


  describe "GET /index" do
    subject{get(api_v1_articles_path)}
    before {create_list(:article,3)}
    fit 'articleのtitle一覧が全員見られるre' do
    subject
    res = JSON.parse(response.body)
    expect(res.length).to eq 3
binding.pry




    end
  end
end
