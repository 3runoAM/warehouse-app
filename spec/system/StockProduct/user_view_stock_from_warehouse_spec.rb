require 'rails_helper'

describe 'Usuário vê o estoque' do
  it 'na tela do galpão' do
    user = User.create!(name: 'User', email: 'user@gmail.com', password: 'password123')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                  description: 'Galpão para armazenamento')
    supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                email: 'brn@email.com')
    product_a = ProductModel.create!(name: 'PRODUTO A', width: 10, heigth: 30, depth: 50, sku: 'PRODUTOA4545', supplier: supplier)
    product_b = ProductModel.create!(name: 'PRODUTO B', width: 30, heigth: 40, depth: 20, sku: 'PRODUTOB5050', supplier: supplier)
    product_c = ProductModel.create!(name: 'PRODUTO C', width: 15, heigth: 20, depth: 10,  sku: 'PRODUTOC3030', supplier: supplier)
    order = Order.create!(warehouse: warehouse, supplier: supplier, user: user,
                          estimated_delivery_date: 1.day.from_now)
    3.times{StockProduct.create!(order: order, warehouse: warehouse, product_model: product_a )}
    2.times{StockProduct.create!(order: order, warehouse: warehouse, product_model: product_b )}

    login_as user
    visit root_path
    click_on 'Galpão Rio'

    within 'section#stock_products' do
      expect(page).to have_content 'Itens em estoque'
      expect(page).to have_content '3 x PRODUTOA4545'
      expect(page).to have_content '2 x PRODUTOB5050'
      expect(page).not_to have_content 'PRODUTOC3030'
    end
  end

  it 'e dá baixa em um item' do
    user = User.create!(name: 'User', email: 'user@gmail.com', password: 'password123')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                  description: 'Galpão para armazenamento')
    supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                email: 'brn@email.com')
    order = Order.create!(warehouse: warehouse, supplier: supplier, user: user,
                          estimated_delivery_date: 1.day.from_now)
    product = ProductModel.create!(name: 'PRODUTO A', width: 10, heigth: 30, depth: 50, sku: 'PRODUTOA4545', supplier: supplier)

    2.times{StockProduct.create!(order: order, warehouse: warehouse, product_model: product)}

    login_as user
    visit root_path
    click_on 'Galpão Rio'
    select 'PRODUTOA4545', from: 'Item para saída'
    fill_in 'Destinatário', with: 'Maria Ferreira'
    fill_in 'Endereço Destino', with: 'Rua xyz, 100 - Campina Grande - Paraíba'
    click_on 'Confirmar retirada'

    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_content 'Item retirado com sucesso'
    expect(page).to have_content '1 x PRODUTOA4545'
  end
end