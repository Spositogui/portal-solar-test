require 'rails_helper'

feature 'Visitor does advanced search', js: true do
  scenario 'successfully' do
    create(:power_generator, name: 'TRIFÁSICO A', manufacturer: 'WEG',
                             price: 39_990.0, structure_type: :metalico)
    create(:power_generator, name: 'TRIFÁSICO B', manufacturer: 'WEG',
                             price: 49_990.0, structure_type: :metalico)
    create(:power_generator, name: 'TRIFÁSICO C ', manufacturer: 'Solar Group',
                             price: 48_990.0, structure_type: :metalico)
    create(:power_generator, name: 'TRIFÁSICO D', manufacturer: 'WEG',
                             price: 50_000.0, structure_type: :fibrocimento)
    create(:power_generator, name: 'TRIFÁSICO E', manufacturer: 'WEG',
                             price: 60_000.0, structure_type: :metalico)

    visit root_path
    find('label', text: 'Pesquisa Avançada').click
    fill_in 'Fabricante', with: 'WEG'
    fill_in 'Preç. Max', with: 50_000
    fill_in 'Preç. Min', with: 40_000
    select 'Metalico', from: 'Tipo de estrutura'
    click_on 'Pesquisar'

    expect(page).to have_content('TRIFÁSICO B')
    expect(page).not_to have_content('TRIFÁSICO A')
    expect(page).not_to have_content('TRIFÁSICO C')
    expect(page).not_to have_content('TRIFÁSICO D')
    expect(page).not_to have_content('TRIFÁSICO E')
  end

  scenario 'and not fill in Fabricante' do
    create(:power_generator, name: 'TRIFÁSICO A', manufacturer: 'WEG',
                             price: 39_990.0, structure_type: :metalico)
    create(:power_generator, name: 'TRIFÁSICO B', manufacturer: 'WEG',
                             price: 49_990.0, structure_type: :metalico)
    create(:power_generator, name: 'TRIFÁSICO C ', manufacturer: 'Solar Group',
                             price: 48_990.0, structure_type: :metalico)
    create(:power_generator, name: 'TRIFÁSICO D', manufacturer: 'WEG',
                             price: 50_000.0, structure_type: :fibrocimento)
    create(:power_generator, name: 'TRIFÁSICO E', manufacturer: 'WEG',
                             price: 60_000.0, structure_type: :metalico)

    visit root_path
    find('label', text: 'Pesquisa Avançada').click
    fill_in 'Preç. Max', with: 50_000
    fill_in 'Preç. Min', with: 40_000
    select 'Metalico', from: 'Tipo de estrutura'
    click_on 'Pesquisar'

    expect(page).to have_content('TRIFÁSICO B')
    expect(page).to have_content('TRIFÁSICO C')
    expect(page).not_to have_content('TRIFÁSICO A')
    expect(page).not_to have_content('TRIFÁSICO D')
    expect(page).not_to have_content('TRIFÁSICO E')
  end

  scenario 'and not fill in Preç. Max' do
    create(:power_generator, name: 'TRIFÁSICO A', manufacturer: 'WEG',
                             price: 39_990.0, structure_type: :metalico)
    create(:power_generator, name: 'TRIFÁSICO B', manufacturer: 'WEG',
                             price: 49_990.0, structure_type: :metalico)
    create(:power_generator, name: 'TRIFÁSICO C ', manufacturer: 'Solar Group',
                             price: 48_990.0, structure_type: :metalico)
    create(:power_generator, name: 'TRIFÁSICO D', manufacturer: 'WEG',
                             price: 50_000.0, structure_type: :fibrocimento)
    create(:power_generator, name: 'TRIFÁSICO E', manufacturer: 'WEG',
                             price: 60_000.0, structure_type: :metalico)

    visit root_path
    find('label', text: 'Pesquisa Avançada').click
    fill_in 'Fabricante', with: 'WEG'
    fill_in 'Preç. Min', with: 40_000
    select 'Metalico', from: 'Tipo de estrutura'
    click_on 'Pesquisar'

    expect(page).to have_content('TRIFÁSICO B')
    expect(page).to have_content('TRIFÁSICO E')
    expect(page).not_to have_content('TRIFÁSICO A')
    expect(page).not_to have_content('TRIFÁSICO C')
    expect(page).not_to have_content('TRIFÁSICO D')
  end

  scenario 'and not fill in Tipo de estrutura' do
    create(:power_generator, name: 'TRIFÁSICO A', manufacturer: 'WEG',
                             price: 39_990.0, structure_type: :metalico)
    create(:power_generator, name: 'TRIFÁSICO B', manufacturer: 'WEG',
                             price: 49_990.0, structure_type: :metalico)
    create(:power_generator, name: 'TRIFÁSICO C ', manufacturer: 'Solar Group',
                             price: 48_990.0, structure_type: :metalico)
    create(:power_generator, name: 'TRIFÁSICO D', manufacturer: 'WEG',
                             price: 50_000.0, structure_type: :fibrocimento)
    create(:power_generator, name: 'TRIFÁSICO E', manufacturer: 'WEG',
                             price: 60_000.0, structure_type: :metalico)

    visit root_path
    find('label', text: 'Pesquisa Avançada').click
    fill_in 'Fabricante', with: 'WEG'
    fill_in 'Preç. Max', with: 50_000
    fill_in 'Preç. Min', with: 40_000
    click_on 'Pesquisar'

    expect(page).to have_content('TRIFÁSICO B')
    expect(page).to have_content('TRIFÁSICO D')
    expect(page).not_to have_content('TRIFÁSICO C')
    expect(page).not_to have_content('TRIFÁSICO A')
    expect(page).not_to have_content('TRIFÁSICO E')
  end

  scenario 'and not fill in Fabricante e Tipo de estrutura' do
    create(:power_generator, name: 'TRIFÁSICO A', manufacturer: 'WEG',
                             price: 39_990.0, structure_type: :metalico)
    create(:power_generator, name: 'TRIFÁSICO B', manufacturer: 'WEG',
                             price: 49_990.0, structure_type: :metalico)
    create(:power_generator, name: 'TRIFÁSICO C ', manufacturer: 'Solar Group',
                             price: 48_990.0, structure_type: :metalico)
    create(:power_generator, name: 'TRIFÁSICO D', manufacturer: 'WEG',
                             price: 50_000.0, structure_type: :fibrocimento)
    create(:power_generator, name: 'TRIFÁSICO E', manufacturer: 'WEG',
                             price: 60_000.0, structure_type: :metalico)

    visit root_path
    find('label', text: 'Pesquisa Avançada').click
    fill_in 'Preç. Max', with: 50_000
    fill_in 'Preç. Min', with: 40_000
    click_on 'Pesquisar'

    expect(page).to have_content('TRIFÁSICO B')
    expect(page).to have_content('TRIFÁSICO C')
    expect(page).to have_content('TRIFÁSICO D')
    expect(page).not_to have_content('TRIFÁSICO A')
    expect(page).not_to have_content('TRIFÁSICO E')
  end

  scenario 'and not fill in any field' do
    visit root_path
    find('label', text: 'Pesquisa Avançada').click
    click_on 'Pesquisar'

    expect(page).to have_content('Nenhum resultado para a sua pesquisa foi '\
                                 'encontrado.')
  end
end
