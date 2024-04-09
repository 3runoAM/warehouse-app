require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                     address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                     description: 'Galpão para armazenamento')

    visit root_path
    click_on 'Galpão Rio'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Armazém Rio'
    expect(page).not_to have_content 'Código SDU'
  end

end