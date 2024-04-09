require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    User.create!(email: 'user001@gmail.com', password: 'password123')

    visit root_path
    click_on 'Login'
    within('form') do
      fill_in 'Email', with: 'user001@gmail.com'
      fill_in 'Senha', with: 'password123'
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso'
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_content 'user001@gmail.com'
      expect(page).to have_button 'Sair'
    end
  end

  it 'e faz log out' do
    User.create(email: 'user2506@email.com', password: 'password123')

    visit root_path
    click_on 'Login'
    within('form') do
      fill_in 'Email', with: 'user2506@email.com'
      fill_in 'Senha', with: 'password123'
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso'
    expect(page).to have_link 'Login'
    expect(page).not_to have_link 'Sair'
  end
end