require 'rails_helper'

describe 'Usuário cadastra um galpão' do
  it 'a partir da tela inicial' do
    #ARRANGE

    #ACT
    visit root_path
    click_on 'Cadastrar Galpão'

    #ASSERT
    expect(page).to have_field('Nome')
    expect(page).to have_field('Código')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Área')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('CEP')
    expect(page).to have_field('Descrição')
  end

  it 'com sucesso' do
    #ARRANGE

    #ACT
    visit root_path
    click_on 'Cadastrar Galpão'
    fill_in 'Nome', with: 'Patos'
    fill_in 'Código', with: 'PTS'
    fill_in 'Cidade', with: 'Patos'
    fill_in 'Área', with: '12000'
    fill_in 'Endereço', with: 'ASve'
    fill_in 'CEP', with: '580000-00'
    fill_in 'Descrição', with: 'Aramazém em Patos - PB'
    click_on 'Criar'

    #ASSERT
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão cadastrado com sucesso'
  end

  it 'com dados incompletos' do
    # Arrange

    # ACT
    visit root_path
    click_on 'Cadastrar Galpão'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Área', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Criar Galpão'

    # ASSERT
    expect(page).to have_content "Nome não pode ficar em branco"
    expect(page).to have_content "Código não pode ficar em branco"
    expect(page).to have_content "Cidade não pode ficar em branco"
    expect(page).to have_content "Área não pode ficar em branco"
    expect(page).to have_content "Endereço não pode ficar em branco"
    expect(page).to have_content "CEP não pode ficar em branco"
    expect(page).to have_content "Descrição não pode ficar em branco"
  end
end