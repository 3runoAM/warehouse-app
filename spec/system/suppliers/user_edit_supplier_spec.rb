require 'rails_helper'

describe 'Usuário edita fornecedor' do
  it 'a partir do menu' do
    first_supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                      city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                      email: 'brn@email.com')

    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'BRN'
    click_on 'Editar fornecedor'

    expect(page).to have_field 'Razão social', with: 'BRN ltd'
    expect(page).to have_field 'Nome fantasia', with: 'BRN'
    expect(page).to have_field 'CNPJ', with: '453354564'
    expect(page).to have_field 'Endereço', with: 'Rua x, 123'
    expect(page).to have_field 'Cidade', with: 'Patos'
    expect(page).to have_field 'Estado', with: 'Paraíba'
    expect(page).to have_field 'Email', with:'brn@email.com'
  end

  it 'com sucesso' do
    first_supplier = Supplier.create!(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                      city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123', email: 'brn@email.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'BRN'
    click_on 'Editar fornecedor'
    fill_in 'Endereço', with: 'Rua y, 321'
    fill_in 'Cidade', with: 'Cajazeira'
    fill_in 'Estado', with: 'Paraíba'
    click_on 'Atualizar Fornecedor'


    expect(page).to have_content 'Fornecedor atualizado com sucesso'
    expect(page).to have_content 'Fornecedor BRN'
    expect(page).to have_content 'Razão social: BRN ltd'
    expect(page).to have_content 'CNPJ: 453354564'
    expect(page).to have_content 'Endereço: Rua y, 321'
    expect(page).to have_content 'Cidade: Cajazeira'
    expect(page).to have_content 'Estado: Paraíba'
    expect(page).to have_content 'Email: brn@email.com'
  end
end