require 'rails_helper'

describe 'Usuário cadastra um novo modelo de produto' do
  it 'com sucesso' do
    User.create(email: 'user2506@email.com', password: 'password123')
    first_supplier = Supplier.create!(corporate_name: 'Samsung ltd', brand_name: 'Samsung',
                                     registration_number: '453354564', city: 'São Paulo', state: 'Saõ Paulo',
                                     full_address: 'Rua x, 123', email: 'brn@email.com')
    second_supplier = Supplier.create!(corporate_name: 'GRN ltd', brand_name: 'GRN',
                                       registration_number: '454635696', city: 'Cajazeiras', state: 'Paraíba',
                                       full_address: 'Rua Y, 321', email: 'grn@email.com')

    visit root_path
    click_on 'Login'
    within('form') do
      fill_in 'Email', with: 'user2506@email.com'
      fill_in 'Senha', with: 'password123'
      click_on 'Entrar'
    end
    click_on 'Modelos de produtos'
    click_on 'Cadastrar novo'
    fill_in 'Nome', with: 'TV 80 polegadas'
    fill_in 'Altura', with: 45
    fill_in 'Largura', with: 70
    fill_in 'Profundidade', with: 10
    fill_in 'Peso', with: 10000
    fill_in 'SKU', with: 'TV32-SAMSU-XPTO90'
    select 'Samsung', from: 'product_model_supplier_id'
    click_on 'Cadastrar Modelo de Produto'

    expect(page).to have_content 'Modelo de produto cadastrado com sucesso'
    expect(page).to have_content 'TV 80 polegadas'
    expect(page).to have_content 'Fornecedor: Samsung'
    expect(page).to have_content 'SKU: TV32-SAMSU-XPTO90'
    expect(page).to have_content 'Dimensões: 45cm x 70cm x 10cm'
    expect(page).to have_content 'Peso: 10000g'
  end

  it 'e deve preencher todos os campos' do
    User.create(email: 'user2506@email.com', password: 'password123')
    supplier = Supplier.create!(corporate_name: 'Samsung ltd', brand_name: 'Samsung',
                                    registration_number: '453354564', city: 'São Paulo', state: 'Saõ Paulo',
                                    full_address: 'Rua x, 123', email: 'brn@email.com')

    visit root_path
    click_on 'Login'
    within('form') do
      fill_in 'Email', with: 'user2506@email.com'
      fill_in 'Senha', with: 'password123'
      click_on 'Entrar'
    end
    click_on 'Modelos de produtos'
    click_on 'Cadastrar novo'
    fill_in 'Nome', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Largura', with: ''
    click_on 'Cadastrar Modelo de Produto'


    expect(page).to have_content 'Problema ao criar modelo de produto'
  end
end