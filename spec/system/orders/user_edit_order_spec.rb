require 'rails_helper'

describe 'Usuário edita pedido' do
  it 'e deve estar autenticado' do
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

    visit edit_order_path(order_one.id)

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    user_one = User.create!(name: 'User0001', email: 'user0001@gmail.com', password: 'password123')
    user_two = User.create!(name: 'User0002', email: 'user0002@gmail.com', password: 'password123')
    supplier_one = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                email: 'brn@email.com')
    supplier_two = Supplier.create!(corporate_name: 'GHP ltd', brand_name: 'GHP', registration_number: '989636599',
                                city: 'Feira Nova', state: 'Pernambuco', full_address: 'Rua w, 1098',
                                email: 'ghp@email.com')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                  description: 'Galpão para armazenamento')

    order_one = Order.create!(user: user_one, supplier: supplier_two, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)
    order_two = Order.create!(user: user_one, supplier: supplier_two, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)
    order_three = Order.create!(user: user_two, supplier: supplier_one, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)

    login_as(user_one)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order_one.code
    click_on 'Editar'
    fill_in 'Data prevista de entrega', with: '12/12/2024'
    select 'GHP ltd', from: 'order_supplier_id'
    click_on 'Atualizar Pedido'

    expect(page).to have_content 'Pedido atualizado com sucesso'
    expect(page).to have_content 'Fornecedor: GHP ltd'
    expect(page).to have_content 'Data prevista de entrega: 12/12/2024'
  end

  it 'caso seja o responsável' do
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
    visit edit_order_path(order_one.id)

    expect(current_path).to eq root_path
  end
end