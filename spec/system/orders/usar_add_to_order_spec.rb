require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
  it 'com sucesso' do
    user = User.create!(name: 'User0001', email: 'user0001@gmail.com', password: 'password123')
    supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                email: 'brn@email.com')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                  description: 'Galpão para armazenamento')
    order = Order.create!(user: user, supplier: supplier, warehouse: warehouse,
                          estimated_delivery_date: 1.day.from_now, status: 'pending')
    product_a = ProductModel.create!(name: 'PRODUTO A', width: 10, heigth: 30, depth: 50, sku: 'PRODUTOA4545',
                                     supplier: supplier)
    product_b = ProductModel.create!(name: 'PRODUTO B', width: 30, heigth: 40, depth: 20, sku: 'PRODUTOB5050',
                                     supplier: supplier)

    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    select 'PRODUTO A', from: 'order_item_product_model_id'
    fill_in 'Quantidade', with: '8'
    click_on 'Adicionar Item'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content "Item adicionado com sucesso"
    expect(page).to have_content '8 x PRODUTO A'
  end

  it 'e não vê produtos de outro fornecedor' do
    user = User.create!(name: 'User0001', email: 'user0001@gmail.com', password: 'password123')
    supplier_a = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                email: 'brn@email.com')
    supplier_b = Supplier.create!(corporate_name: 'KMG LTD', brand_name: 'KMG', registration_number: '738946845',
                                city: 'Pombal', state: 'Paraíba', full_address: 'Rua p, 369',
                                email: 'kmg@email.com')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                  description: 'Galpão para armazenamento')
    order = Order.create!(user: user, supplier: supplier_a, warehouse: warehouse,
                          estimated_delivery_date: 1.day.from_now, status: 'pending')
    product_a = ProductModel.create!(name: 'PRODUTO A', width: 10, heigth: 30, depth: 50, sku: 'PRODUTOA4545',
                                     supplier: supplier_a)
    product_b = ProductModel.create!(name: 'PRODUTO B', width: 30, heigth: 40, depth: 20, sku: 'PRODUTOB5050',
                                     supplier: supplier_b)

    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    expect(page).to have_content 'PRODUTO A'
    expect(page).not_to have_content 'PRODUTO B'
  end
end