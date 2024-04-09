require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'e deve estar cadastrado' do
    visit root_path
    click_on 'Registrar Pedido'

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    user = User.create!(name: 'User', email: 'user@gmail.com', password: 'password123')
    first_supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                              city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                              email: 'brn@email.com')
    second_supplier = Supplier.create!(corporate_name: 'THK ltd', brand_name: 'THK', registration_number: '489489875',
                              city: 'Cajazeiras', state: 'Paraíba', full_address: 'Rua y, 567',
                              email: 'thk@gmail.com')
    first_warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                     address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                     description: 'Galpão para armazenamento')
    second_warehouse = Warehouse.create!(name: 'Patos', code: 'PTS', city: 'Patos', area: 60_000,
                     address: 'Avenida dos meteoros, 52000', CEP: '58000-00',
                     description: 'Galpão para venda')

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCD12345') # Rspecs mocks

    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'SDU - Rio', from: 'order_warehouse_id'
    select 'BRN ltd', from: 'order_supplier_id'
    fill_in 'Data prevista', with: '21/12/2024'
    click_on 'Criar Pedido'

    expect(page).to have_content 'Pedido cadastrado com sucesso'
    expect(page).to have_content 'Pedido ABCD12345'
    expect(page).to have_content 'Galpão de destino: SDU - Rio'
    expect(page).to have_content 'Status do pedido: Pendente'
    expect(page).to have_content 'Fornecedor: BRN ltd'
    expect(page).to have_content 'Usuário responsável: User | user@gmail.com |'
    expect(page).to have_content 'Data prevista de entrega: 21/12/2024'
  end

  it 'e a data prevista de entrega não pode estar no passado' do
    user = User.create!(name: 'User', email: 'user@gmail.com', password: 'password123')
    supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                  city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                  email: 'brn@email.com')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                    description: 'Galpão para armazenamento')
    login_as(user)
      visit root_path
      click_on 'Registrar Pedido'
      select 'SDU - Rio', from: 'order_warehouse_id'
      select 'BRN ltd', from: 'order_supplier_id'
      fill_in 'Data prevista', with: 1.day.ago
      click_on 'Criar Pedido'

    expect(page).to have_content 'Data prevista de entrega deve ser futura'
  end
end