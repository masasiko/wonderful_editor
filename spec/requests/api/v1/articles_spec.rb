require 'rails_helper'


RSpec.describe "Api::V1::Articles", type: :request do


  describe "GET /index" do
    subject{get(api_v1_articles_path)}
    before{create_list(:article, article_count)}
    let(:article_count){3}
    fit 'articleの一覧が表示される' do
    subject
    article=Article.all
    res = JSON.parse(response.body)
    expect(res.length).to eq article_count
    expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
    expect(res.sort_by{ |hash| -hash["created_at"].to_i }).to eq res.sort_by{"created_at"}
    expect(response).to have_http_status(200)
    end
  end
end
