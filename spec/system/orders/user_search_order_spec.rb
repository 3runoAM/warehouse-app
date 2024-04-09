require 'rails_helper'

describe 'Usuário busca por um pedido' do
  it 'e deve estar autenticada' do
    user = User.create!(name: 'User', email: 'user@gmail.com', password: 'password123')

    login_as(user)
    visit root_path

    within('nav') do
      expect(page).to have_field('Buscar pedido')
      expect(page).to have_button('Buscar')
    end
  end

  it ' e encontra um pedido' do
    user = User.create!(name: 'User', email: 'user@gmail.com', password: 'password123')
    supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                email: 'brn@email.com')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                  description: 'Galpão para armazenamento')
    order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)

    login_as(user)
    visit root_path
    fill_in 'Buscar pedido', with: order.code
    click_on 'Buscar'


    expect(page).to have_content "Resultados da busca por #{order.code}"
    expect(page).to have_content "1 pedido encontrado"
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content "Galpão de destino: SDU - Rio"
    expect(page).to have_content "Fornecedor: BRN ltd"
  end

  it 'e encontra múltiplos pedidos' do
    user = User.create!(name: 'User', email: 'user@gmail.com', password: 'password123')
    supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                email: 'brn@email.com')
    first_warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                  description: 'Galpão para armazenamento')
    second_warehouse = Warehouse.create!(name: 'Patos', code: 'PTS', city: 'Patos', area: 60_000,
                                  address: 'Avenida das pedras, 55000', CEP: '58000-00',
                                  description: 'Galpão para vendas')

    allow(SecureRandom).to receive(:alphanumeric).and_return('SDU12345')
    first_order = Order.create!(user: user, supplier: supplier, warehouse: first_warehouse,
                                estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).and_return('SDU54321')
    second_order = Order.create!(user: user, supplier: supplier, warehouse: first_warehouse,
                                 estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).and_return('PTS78946')
    third_order = Order.create!(user: user, supplier: supplier, warehouse: second_warehouse,
                                estimated_delivery_date: 1.day.from_now)

    login_as(user)
    visit root_path
    fill_in 'Buscar pedido', with: 'SDU'
    click_on 'Buscar'


    expect(page).to have_content "Resultados da busca por SDU"
    expect(page).to have_content "2 pedidos encontrados"
    expect(page).to have_content 'SDU12345'
    expect(page).to have_content 'SDU54321'
    expect(page).to have_content "Galpão de destino: SDU - Rio"
    expect(page).not_to have_content 'PTS78946'
    expect(page).not_to have_content 'Galpão de destino: PTS - Patos'
  end
end