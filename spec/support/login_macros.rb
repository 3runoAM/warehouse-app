def login(user)
  click_on 'Login'
  within('form') do
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'
  end
end