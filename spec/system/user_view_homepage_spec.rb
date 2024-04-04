require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it "e vê home page" do
    #Arrange
    #Act
    visit('/')
    #Assert
    expect(page).to have_content('Galpões & Estoque')
  end
  # it '' do
  #
  # end
  #
  # it '' do
  #
  # end
end