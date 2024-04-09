require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouse/1' do
    it 'success' do
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                    description: 'Galpão para armazenamento')

      get "/api/v1/warehouse/#{warehouse.id}"

      expect(response).to have_http_status 200 #ok
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include('Rio')
    end
  end
end