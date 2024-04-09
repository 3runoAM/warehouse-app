require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    it 'name is mandatory' do
      supplier = Supplier.create!(corporate_name: 'Samsung ltd', brand_name: 'Samsung',
                                       registration_number: '453354564', city: 'São Paulo', state: 'Saõ Paulo',
                                       full_address: 'Rua x, 123', email: 'brn@email.com')

      pm = ProductModel.new(weight: 8000, width: 70, heigth: 45, depth: 10,
                           sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

      expect(pm).not_to be_valid
    end

    it 'sku is mandatory' do
      supplier = Supplier.create!(corporate_name: 'Samsung ltd', brand_name: 'Samsung',
                                  registration_number: '453354564', city: 'São Paulo', state: 'Saõ Paulo',
                                  full_address: 'Rua x, 123', email: 'brn@email.com')

      pm = ProductModel.new(name: 'TV 80 polegadas', weight: 8000, width: 70, heigth: 45, depth: 10, supplier: supplier)

      expect(pm).not_to be_valid
    end
  end
end
