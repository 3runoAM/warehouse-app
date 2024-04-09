require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouse/1' do
    it 'success' do
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                    description: 'Galpão para armazenamento')

      get "/api/v1/warehouses/#{warehouse.id}"


      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq 'Rio'
      expect(json_response['code']).to eq 'SDU'
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')
    end

    it 'fail if not found' do
      get "/api/v1/warehouses/4536911"

      expect(response.status).to eq 404
    end
  end
  context 'GET /apiu/v1/warehoses' do
    it 'com sucesso' do

    end
  end
end