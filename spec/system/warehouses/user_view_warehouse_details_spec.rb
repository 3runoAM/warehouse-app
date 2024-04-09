require 'rails_helper'

describe 'Usuário vê detalhes do galpão' do
  it 'e vê informações adicionais' do
    #Arrange
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                     address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                     description: 'Galpão para armazenamento')

    #Act
    visit root_path 
    click_on 'Galpão Rio'

    #Assert
    expect(page).to have_content 'Galpão SDU'
    expect(page).to have_content 'Rio'
    expect(page).to have_content 'Rio de Janeiro'
    expect(page).to have_content '60000'
    expect(page).to have_content 'Avenida das estrelas, 5000'
    expect(page).to have_content '15000-00'
    expect(page).to have_content 'Galpão para armazenamento'
  end

  it 'e volta a tela inicial' do
    #Arrange
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                     address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                     description: 'Galpão para armazenamento')

    #Act
    visit root_path
    click_on 'Galpão Rio'
    click_on 'Home'

    # Assert
    expect(current_path).to eq root_path
  end
end