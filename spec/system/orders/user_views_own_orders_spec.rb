require 'rails_helper'

describe 'Usuário vê os próprios pedidos' do
  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Meus Pedidos'

    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê outros pedidos' do
    user_one = User.create!(name: 'User0001', email: 'user0001@gmail.com', password: 'password123')
    user_two = User.create!(name: 'User0002', email: 'user0002@gmail.com', password: 'password123')
    supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                email: 'brn@email.com')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                  description: 'Galpão para armazenamento')

    order_one = Order.create!(user: user_one, supplier: supplier, warehouse: warehouse,
                              estimated_delivery_date: 1.day.from_now, status: 'pending')
    order_two = Order.create!(user: user_one, supplier: supplier, warehouse: warehouse,
                              estimated_delivery_date: 1.day.from_now, status: 'delivered')
    order_three = Order.create!(user: user_two, supplier: supplier, warehouse: warehouse,
                                estimated_delivery_date: 1.day.from_now, status: 'canceled')

    login_as(user_one)
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content order_one.code
    expect(page).to have_content 'Pendente'
    expect(page).to have_content order_two.code
    expect(page).to have_content 'Entregue'
    expect(page).not_to have_content order_three.code
    expect(page).not_to have_content 'Cancelado'
  end

  it 'e visita um pedido' do
    user_one = User.create!(name: 'User0001', email: 'user0001@gmail.com', password: 'password123')
    user_two = User.create!(name: 'User0002', email: 'user0002@gmail.com', password: 'password123')
    supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                email: 'brn@email.com')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                  description: 'Galpão para armazenamento')

    order_one = Order.create!(user: user_one, supplier: supplier, warehouse: warehouse,
                              estimated_delivery_date: 1.day.from_now)
    order_two = Order.create!(user: user_one, supplier: supplier, warehouse: warehouse,
                              estimated_delivery_date: 1.day.from_now)
    order_three = Order.create!(user: user_two, supplier: supplier, warehouse: warehouse,
                                estimated_delivery_date: 1.day.from_now)

    login_as(user_one)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order_one.code

    expect(page).to have_content 'Detalhes do pedido'
    expect(page).to have_content order_one.code
    expect(page).to have_content 'Galpão de destino: SDU - Rio'
    expect(page).to have_content 'Fornecedor: BRN ltd'
    expect(page).to have_content "Data prevista de entrega: #{I18n.localize(1.day.from_now.to_date)}"
  end

  it 'e não consegue acessar os pedidos de outro usuário' do
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

    login_as(user_one)
    visit order_path(order_three.id)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a este pedido.'
  end

  it 'e vê itens de pedido' do
    supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                email: 'brn@email.com')

    product_a = ProductModel.create!(name: 'PRODUTO A', width: 10, heigth: 30, depth: 50, sku: 'PRODUTOA4545', supplier: supplier)
    product_b = ProductModel.create!(name: 'PRODUTO B', width: 30, heigth: 40, depth: 20, sku: 'PRODUTOB5050', supplier: supplier)
    product_c = ProductModel.create!(name: 'PRODUTO C', width: 15, heigth: 20, depth: 10,  sku: 'PRODUTOA3030', supplier: supplier)

    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                  description: 'Galpão para armazenamento')
    user = User.create!(name: 'User0002', email: 'user0002@gmail.com', password: 'password123')

    order = Order.create!(user: user, supplier: supplier, warehouse: warehouse,
                              estimated_delivery_date: 1.day.from_now, status: 'pending')

    first_item = OrderItem.create!(product_model: product_a, order: order, quantity: 19)
    second_item = OrderItem.create!(product_model: product_b, order: order, quantity: 50)


    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    expect(page).to have_content 'Itens do pedido'
    expect(page).to have_content '19 x PRODUTO A'
    expect(page).to have_content '50 x PRODUTO B'
  end
end