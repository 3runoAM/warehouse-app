require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor' do
  it 'a partir da tela inicial' do
    first_supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                       city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123', email: 'brn@email.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'BRN'

    expect(page).to have_content 'Fornecedor BRN'
    expect(page).to have_content 'Razão social: BRN ltd'
    expect(page).to have_content 'CNPJ: 453354564'
    expect(page).to have_content 'Cidade: Patos'
    expect(page).to have_content 'Estado: Paraíba'
    expect(page).to have_content 'Endereço: Rua x, 123'
    expect(page).to have_content 'Email: brn@email.com'
  end

  it 'e volta para a tela inicial ' do
    first_supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                      city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123', email: 'brn@email.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'BRN'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end