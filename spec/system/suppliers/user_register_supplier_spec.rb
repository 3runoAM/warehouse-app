require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
  it 'a partir do menu' do
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar novo fornecedor'

    expect(page).to have_field 'Razão social'
    expect(page).to have_field 'Nome fantasia'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'Email'
  end
  it 'com sucesso' do
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Razão social', with: 'BRN ltd'
    fill_in 'Nome fantasia', with: 'BRN'
    fill_in 'CNPJ', with: '453354564'
    fill_in 'Endereço', with: 'Rua x, 123'
    fill_in 'Cidade', with: 'Patos'
    fill_in 'Estado', with: 'Paraíba'
    fill_in 'Email', with: 'brn@email.com'
    click_on 'Criar Fornecedor'

    expect(page).to have_content 'Fornecedor criado com sucesso'
    expect(page).to have_content 'Fornecedor BRN'
    expect(page).to have_content 'Razão social: BRN ltd'
    expect(page).to have_content 'CNPJ: 453354564'
    expect(page).to have_content 'Endereço: Rua x, 123'
    expect(page).to have_content 'Cidade: Patos'
    expect(page).to have_content 'Estado: Paraíba'
    expect(page).to have_content 'Email: brn@email.com'
  end
end