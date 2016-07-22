require 'spec_helper'

describe API::V1::Birds, type: :api do
  let(:app) { API::V1::Birds }
  
  before do
    app.before { env["api.tilt.root"] = File.join(ENV['API_ROOT'], 'app', 'views') }
  end

  let(:valid_request_params) do 
    {bird: {name:"King Penguin", family: "Penguin", continents:["Antarctica"]}}
  end

  let(:invalid_request_params) do
    {"bird": {"names":"King Penguin", "families": "Penguin", "continent":["Antarctica"]}}
  end

  context 'POST register a bird' do

    it 'return 201 status when requested with valid_request_params' do
      post '/api/v1/birds', valid_request_params.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq 201
    end

    it 'returns 400 status when requested with invalid_request_params' do
      post '/api/v1/birds', invalid_request_params.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(400)
      expect(JSON.parse(last_response.body)).to eq ({"error"=>"bird[name] is missing, bird[family] is missing, bird[continents] is missing"})
    end
  end

  context 'GET registered birds' do
    it 'returns 200 status with the list of birds registered' do
      birds = { birds: Bird.only(:id).map{|b| b.id.to_s } }.to_json
      get '/api/v1/birds', 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(birds)
    end
  end

  context 'GET registered bird' do
    it 'returns 200 status with registered bird' do
      bird = Bird.last #register(valid_request_params[:bird])
      get "/api/v1/birds/#{bird.id.to_s}", 'CONTENT_TYPE' => 'application/json'
      expected_response = {id: bird.id.to_s, name:"King Penguin", visible: false, added: "2016-07-22", family: "Penguin", continents:["Antarctica"]}.to_json

      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(expected_response)
    end

    it 'returns 404 status with unregistered bird' do
      get "/api/v1/birds/ajgf83y84398"
      expect(last_response.status).to eq(404)
    end
  end

  context 'DELETE registered bird' do
    it 'returns 200 when bird is found' do
      bird = Bird.last #register(valid_request_params[:bird])
      delete "/api/v1/birds/#{bird.id.to_s}", 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(200)
    end

    it 'returns 400 when bird not found' do
      delete "/api/v1/birds/ajgf83y84398", 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(404)
    end
  end
end