require 'rails_helper'

describe 'Usuário se resgistra' do
  it 'com sucesso' do
    visit root_path
    click_on 'Login'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'User265'
    fill_in 'Email', with: 'user265@gmail.com'
    fill_in 'Senha', with: 'password123'
    fill_in 'Confirme sua senha', with: 'password123'
    click_on 'Criar conta'

    expect(page).to have_content 'Boas-vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'user265@gmail.com'
    expect(page).to have_button 'Sair'
    expect(User.last.name).to eq 'User265'
  end
end