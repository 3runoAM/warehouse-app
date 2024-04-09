require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e informa o status entregue' do
    user = User.create!(name: 'User0001', email: 'user0001@gmail.com', password: 'password123')
    supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                email: 'brn@email.com')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                  description: 'Galpão para armazenamento')

    product = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', weight: 5,
                                        heigth: 100, width: 70, sku: 'CADEIRA-GRAMER-BLUE-100')

    order = Order.create!(user: user, supplier: supplier, warehouse: warehouse,
                              estimated_delivery_date: 1.day.from_now, status: 'pending')

    order_item = OrderItem.create!(order: order, product_model: product, quantity: 5)
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como Entregue'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do pedido: Entregue'
    expect(page).not_to have_button 'Marcar como Entregue'
    expect(page).not_to have_button 'Marcar como Cancelado'
    expect(StockProduct.count).to eq 5
    expect((StockProduct.where product_model: product, warehouse: warehouse).count).to eq 5
  end

  it 'e informa o status cancelado' do
    user = User.create!(name: 'User0001', email: 'user0001@gmail.com', password: 'password123')
    supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                email: 'brn@email.com')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                  description: 'Galpão para armazenamento')

    product = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', weight: 5,
                                   heigth: 100, width: 70, sku: 'CADEIRA-GRAMER-BLUE-100')

    order = Order.create!(user: user, supplier: supplier, warehouse: warehouse,
                          estimated_delivery_date: 1.day.from_now, status: 'pending')

    order_item = OrderItem.create!(order: order, product_model: product, quantity: 5)

    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como Cancelado'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do pedido: Cancelado'
    expect(StockProduct.count).to eq 0
  end

end