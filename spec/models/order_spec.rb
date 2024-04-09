require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      user = User.create!(name: 'User', email: 'user@gmail.com', password: 'password123')
      supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                  city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                  email: 'brn@email.com')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                    description: 'Galpão para armazenamento')
      order = Order.new(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: '2024-06-10')

      expect(order).to be_valid
    end
    it 'data estimada de entrega deve ser obrigatória' do
      user = User.create!(name: 'User', email: 'user@gmail.com', password: 'password123')
      supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                  city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                  email: 'brn@email.com')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                    description: 'Galpão para armazenamento')

      order = Order.new(user: user, supplier: supplier, warehouse: warehouse)
      order.valid?

      expect(order.errors.include? :estimated_delivery_date).to be true
    end

    it 'data prevista de entrega não pode estar no passado' do
      order = Order.new(estimated_delivery_date: 1.day.ago)

      order.valid?
      expect(order.errors.include? :estimated_delivery_date).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura.')
    end

    it 'data prevista de entrega não pode ser igual a hoje' do
      order = Order.new(estimated_delivery_date: Date.today)

      order.valid?
      expect(order.errors.include? :estimated_delivery_date).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura.')
    end

    it 'data prevista de entrega deve ser igual ou maior que amanhã' do
      order = Order.new(estimated_delivery_date: 1.day.from_now)

      order.valid?
      expect(order.errors.include? :estimated_delivery_date).to be false
    end
  end
  describe 'Gera um código aleatório' do
    it 'ao criar um novo pedido' do
      user = User.create!(name: 'User', email: 'user@gmail.com', password: 'password123')
      supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                        city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                        email: 'brn@email.com')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                          address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                          description: 'Galpão para armazenamento')
      order = Order.new(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: '2024-06-10')
      order.save

      expect(order.code).not_to be_empty
      expect(order.code.length).to eq 8
    end

    it 'e é único' do
      user = User.create!(name: 'User', email: 'user@gmail.com', password: 'password123')
      supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                  city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                  email: 'brn@email.com')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                    description: 'Galpão para armazenamento')

      first_order = Order.create!(user: user, supplier: supplier, warehouse: warehouse,
                                  estimated_delivery_date: '2024-06-10')
      second_order = Order.new(user: user, supplier: supplier, warehouse: warehouse,
                                   estimated_delivery_date: '2024-07-10')

      second_order.save

      expect(second_order.code).not_to eq(first_order.code)
    end

    it 'e não pode ser modificado' do
      user = User.create!(name: 'User', email: 'user@gmail.com', password: 'password123')
      supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                  city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                  email: 'brn@email.com')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                    description: 'Galpão para armazenamento')
      order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: '2024-06-10')
      original_code = order.code

      order.update(estimated_delivery_date: 1.month.from_now)

      expect(order.code).to eq original_code
    end
  end
end
