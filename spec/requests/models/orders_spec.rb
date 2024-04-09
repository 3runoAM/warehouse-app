require 'rails_helper'

RSpec.describe "orders", type: :request do
  describe "Usuário edita um pedido" do
    it 'e não é o dono' do
      user_one = User.create!(name: 'User0001', email: 'user0001@gmail.com', password: 'password123')
      user_two = User.create!(name: 'User0002', email: 'user0002@gmail.com', password: 'password123')
      supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                  city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                  email: 'brn@email.com')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                    description: 'Galpão para armazenamento')

      order_one = Order.create!(user: user_one, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)
      order_two = Order.create!(user: user_one, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)
      order_three = Order.create!(user: user_two, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)

      login_as(user_two)
      patch(order_path(order_one.id)) # params: {order: {supplier_id: 3}})

      expect(response).to redirect_to(root_path)
    end
  end
end
