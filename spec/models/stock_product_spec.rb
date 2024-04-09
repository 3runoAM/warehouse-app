require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um número de série' do
    it 'ao criar um StockProduct' do
      user = User.create!(name: 'User0001', email: 'user0001@gmail.com', password: 'password123')
      supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                  city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                  email: 'brn@email.com')

      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                    description: 'Galpão para armazenamento')

      order = Order.create!(user: user, supplier: supplier, warehouse: warehouse,
                            estimated_delivery_date: 1.day.from_now, status: 'pending')

      product = ProductModel.create!(name: 'PRODUTO A', width: 10, heigth: 30, depth: 50,
                                     sku: 'PRODUTOA4545', supplier: supplier)

      stock_product = StockProduct.create!(order:order, warehouse: warehouse, product_model: product)

      expect(stock_product.serial_number.length).to eq 20
    end
    it 'e não é modificado' do
      user = User.create!(name: 'User0001', email: 'user0001@gmail.com', password: 'password123')
      supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                  city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                  email: 'brn@email.com')

      first_warehouse = Warehouse.create!(name: 'Rio', code: 'PTS', city: 'Patos', area: 60_000,
                                    address: 'Avenida das pedras, 58000', CEP: '58701-00',
                                    description: 'Galpão para vendas')

      second_warehouse = Warehouse.create!(name: 'Patos', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                    description: 'Galpão para armazenamento')

      order = Order.create!(user: user, supplier: supplier, warehouse: second_warehouse,
                            estimated_delivery_date: 1.day.from_now, status: 'pending')

      product = ProductModel.create!(name: 'PRODUTO A', width: 10, heigth: 30, depth: 50,
                                     sku: 'PRODUTOA4545', supplier: supplier)

      stock_product = StockProduct.create!(order:order, warehouse: first_warehouse, product_model: product)
      original_serial_number = stock_product.serial_number

      stock_product.update(warehouse: second_warehouse)
    end
  end
  describe '#available?' do
    it 'true se não há destino' do
      user = User.create!(name: 'User0001', email: 'user0001@gmail.com', password: 'password123')
      supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                  city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                  email: 'brn@email.com')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                    description: 'Galpão para armazenamento')
      order = Order.create!(user: user, supplier: supplier, warehouse: warehouse,
                            estimated_delivery_date: 1.day.from_now, status: 'pending')
      product = ProductModel.create!(name: 'PRODUTO A', width: 10, heigth: 30, depth: 50,
                                     sku: 'PRODUTOA4545', supplier: supplier)

      stock_product = StockProduct.create!(order:order, warehouse: warehouse, product_model: product)

      expect(stock_product.available?).to eq true
    end
    it 'false se há destino' do
      user = User.create!(name: 'User0001', email: 'user0001@gmail.com', password: 'password123')
      supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                  city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                  email: 'brn@email.com')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                    description: 'Galpão para armazenamento')
      order = Order.create!(user: user, supplier: supplier, warehouse: warehouse,
                            estimated_delivery_date: 1.day.from_now, status: 'pending')
      product = ProductModel.create!(name: 'PRODUTO A', width: 10, heigth: 30, depth: 50,
                                     sku: 'PRODUTOA4545', supplier: supplier)

      stock_product = StockProduct.create!(order:order, warehouse: warehouse, product_model: product)
      stock_product.create_stock_product_destination!(recipient: "Bruno", address: "Rua xyw, 159, Patos - Paraíba")

      expect(stock_product.available?).to eq false
    end
  end
end
