require 'rails_helper'

describe 'Usuário edita um galpão' do
  it 'a partir da página de detalhes' do
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                     address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                     description: 'Galpão para armazenamento')

    visit root_path
    click_on 'Galpão Rio'
    click_on 'Editar'

    expect(page).to have_field('Nome', with: 'Rio')
    expect(page).to have_field('Código', with: 'SDU')
    expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
    expect(page).to have_field('Área', with: '60000')
    expect(page).to have_field('Endereço', with: 'Avenida das estrelas, 5000')
    expect(page).to have_field('CEP', with: '15000-00')
    expect(page).to have_field('Descrição', with: 'Galpão para armazenamento')
  end

  it 'com sucesso' do
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                      address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                      description: 'Galpão para armazenamento')

    visit root_path
    click_on 'Galpão Rio'
    click_on 'Editar'
    fill_in 'Nome', with: 'Patos'
    fill_in 'Código', with: 'PTS'
    fill_in 'Cidade', with: 'Patos'
    fill_in 'CEP', with: '58000-00'
    click_on 'Atualizar Galpão'

    expect(page).to have_content 'Galpão atualizado com sucesso'
    expect(page).to have_content 'Galpão PTS'
    expect(page).to have_content 'Nome: Patos'
    expect(page).to have_content 'Cidade: Patos'
    expect(page).to have_content 'CEP: 58000-00'
    expect(page).to have_content 'Descrição: Galpão para armazenamento'
  end

  it 'e mantém os campos obrigatórios' do
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                      address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                      description: 'Galpão para armazenamento')

    visit root_path
    click_on 'Galpão Rio'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'CEP', with: ''
    click_on 'Atualizar Galpão'

    expect(page).to have_content 'Problema ao atualizar o galpão'
  end
end