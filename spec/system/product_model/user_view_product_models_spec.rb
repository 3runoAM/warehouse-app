require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
  it 'se estiver autenticado' do

    visit root_path
    within('nav') do
      click_on 'Modelos de produtos'
    end

    expect(current_path).to eq new_user_session_path
  end
  it 'a partir do menu' do
    user = User.create(email: 'user2506@email.com', password: 'password123')


    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on 'Modelos de produtos'
    end

    expect(current_path).to eq product_models_path
  end

  it 'com sucesso' do
    user = User.create(email: 'user006@email.com', password: 'password123')
    supplier = Supplier.create!(corporate_name: 'Samsung ltd', brand_name: 'Samsung',
                                registration_number: '453354564', city: 'São Paulo', state: 'Saõ Paulo', full_address: 'Rua x, 123',
                                email: 'brn@email.com')
    ProductModel.create!(name: 'TV 80', weight: 8000, width: 70, heigth: 45, depth: 10,
                         sku: 'TV32-SAMSU-XPTO90', supplier: supplier)
    ProductModel.create!(name: 'Soundbar', weight: 500, width: 20, heigth: 15, depth: 8,
                         sku: 'SOUND-BAR-SAMSU-XABCO70', supplier: supplier)

    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on 'Modelos de produtos'
    end


    expect(page).to have_content 'TV 80'
    expect(page).to have_content 'TV32-SAMSU-XPTO90'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'Soundbar'
    expect(page).to have_content 'SOUND-BAR-SAMSU-XABCO70'
    expect(page).to have_content 'Samsung'
  end

  it 'e não existem produtos cadastrados' do
    user = User.create(email: 'user2506@email.com', password: 'password123')

    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on 'Modelos de produtos'
    end

    expect(page).to have_content 'Não existem modelos de produtos cadastrados'
  end
end