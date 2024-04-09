require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it "e vê home page" do
    #Arrange
    #Act
    visit('/')
    #Assert
    #
    expect(page).to have_content('Galpões & Estoque')
    expect(page).to have_link('Galpões & Estoque', href: root_path)
  end

  it "e vê os galpões cadastrados" do
    #Arrange
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                     address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                     description: 'Galpão para armazenamento')
    Warehouse.create(name: 'Maceio', code: 'MZC', city: 'Maceio', area: 50_000,
                     address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                     description: 'Galpão para armazenamento')

    #Act
    visit('/')

    #Assert
    expect(page).not_to have_content('Não existem galpões cadastrados')
    expect(page).to have_content('Rio')
    expect(page).to have_content('SDU')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('60000 m²')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('MZC')
    expect(page).to have_content('Maceio')
    expect(page).to have_content('50000 m²')
  end

  it 'e vê que não existem galpões cadastrados, caso não existeam' do
    #Arrage

    #Act
    visit('/')

    #Assert
    expect(page).to have_content('Não existem galpões cadastrados')
  end
end