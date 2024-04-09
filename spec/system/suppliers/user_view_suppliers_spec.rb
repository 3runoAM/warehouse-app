require 'rails_helper'

describe 'Usuário vê fornecedores' do
  it 'a partir do menu' do
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end

    expect(current_path).to eq suppliers_path
  end

  it 'com sucesso' do
    first_supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                   city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123', email: 'brn@email.com')
    second_supplier = Supplier.create!(corporate_name: 'GRN ltd', brand_name: 'GRN', registration_number: '454635696',
                                   city: 'Cajazeiras', state: 'Paraíba', full_address: 'Rua Y, 321', email: 'grn@email.com')

    visit root_path
    click_on 'Fornecedores'

    expect(page).to have_content 'Fornecedores cadastrados'
    expect(page).to have_content 'BRN'
    expect(page).to have_content 'Patos - Paraíba'
    expect(page).to have_content 'GRN'
    expect(page).to have_content 'Cajazeiras - Paraíba'
  end

  it 'e não existem fornecedores cadastrados' do
    visit root_path
    click_on 'Fornecedores'

    expect(page).to have_content 'Não existem fornecedores cadastrados'
  end
end