require 'rails_helper'

RSpec.describe "Warehouses", type: :model do
  describe "#valid?" do
    context 'presence' do
      it 'false when name is empty' do
        #ARRANGE
        warehouse = Warehouse.new(name: '', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                  description: 'Galpão para armazenamento')
        #ACT
        result = warehouse.valid?

        #ASSERT
        expect(result).to eq false
      end

      it 'false when code is empty' do
        #ARRANGE
        warehouse = Warehouse.new(name: 'Rio', code: '', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                  description: 'Galpão para armazenamento')
        #ACT
        result = warehouse.valid?

        #ASSERT
        expect(result).to eq false
      end

      it 'false when city is empty' do
        #ARRANGE
        warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: '', area: 60_000,
                                  address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                  description: 'Galpão para armazenamento')
        #ACT
        result = warehouse.valid?

        #ASSERT
        expect(result).to eq false
      end

      it 'false when area is empty' do
        #ARRANGE
        warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro',
                                  address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                  description: 'Galpão para armazenamento')
        #ACT
        result = warehouse.valid?

        #ASSERT
        expect(result).to eq false
      end

      it 'false when address is empty' do
        #ARRANGE
        warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: '', CEP: '15000-00',
                                  description: 'Galpão para armazenamento')
        #ACT
        result = warehouse.valid?

        #ASSERT
        expect(result).to eq false
      end
      it 'false when CEP is empty' do
        #ARRANGE
        warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida das estrelas, 5000', CEP: '',
                                  description: 'Galpão para armazenamento')
        #ACT
        result = warehouse.valid?

        #ASSERT
        expect(result).to eq false
      end
      it 'false when description is empty' do
        #ARRANGE
        warehouse = Warehouse.new(name: '', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                  description: '')
        #ACT
        result = warehouse.valid?

        #ASSERT
        expect(result).to eq false
      end
    end

    context 'uniqueness' do
      it 'false when code is already in use' do
        first_warehouse = Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                           address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                           description: 'Galpão para armazenamento')
        second_warehouse = Warehouse.new(name: 'Patos', code: 'SDU', city: 'Patos', area: 20_000,
                                         address: 'Avenida dos bichos, 5500', CEP: '58000-00',
                                         description: 'Galpão para venda')

        expect(second_warehouse).not_to be_valid
      end
    end
  end

  describe '#full_descripiton' do
    it 'exibe nome e código' do
      w = Warehouse.new(name: 'Rio', code: 'SDU')

      expect(w.full_description).to eq('SDU - Rio')
    end
  end
end
