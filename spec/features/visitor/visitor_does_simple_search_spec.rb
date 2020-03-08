require 'rails_helper'

feature 'Visitor does a simple search' do
  scenario 'successfully' do
    create(:power_generator, name: 'YC600 Monofásico', description:
              'O APsystems YC600i com 600W de potência de saída e duplo MPPT.')
    create(:power_generator, name: 'WEG HÍBRIDO', description:
              'Fácil instalação por apenas uma pessoa com peso de 10,6 kg '\
              'Conector CA otimizado para rápida ligação')

    visit root_path
    find('.simple-form').fill_in 'simple search', with: 'monofásico'
    click_on 'Pesquisar'

    expect(page).to have_content('YC600 Monofásico'.upcase)
    expect(page).to have_content('Descrição: O APsystems YC600i com 600W de '\
                                 'potência de saída e duplo MPPT.')
    expect(page).not_to have_content('WEG HÍBRIDO')
  end

  scenario 'and for more than one result' do
    create(:power_generator, name: 'TRIFÁSICO 380V', description:
      'Consectetur labore elit cillum esse occaecat aliquip id')
    create(:power_generator, name: 'FRONIUS TRAPEZOIDAL', description:
            'Eu anim ad non quis consequat culpa adipisicing laboris trifasico')
    create(:power_generator, name: 'REFUSOL LAJE', description:
            'Lorem commodo velit trifasico tempor officia nulla deserunt non')
    create(:power_generator, name: 'WEG HÍBRIDO', description:
            'Fácil instalação por apenas uma pessoa com peso de 10,6 kg')

    visit root_path
    find('.simple-form').fill_in 'simple search', with: 'trifásico'
    click_on 'Pesquisar'

    expect(page).to have_content('TRIFÁSICO 380V')
    expect(page).to have_content('FRONIUS TRAPEZOIDAL')
    expect(page).to have_content('REFUSOL LAJE')
    expect(page).not_to have_content('WEB HÍBRIDO')
  end

  scenario 'and search not found' do
    visit root_path
    find('.simple-form').fill_in 'simple search', with: 'weg'
    click_on 'Pesquisar'

    expect(page).to have_content('Nenhum resultado para a sua pesquisa foi'\
                                 ' encontrado.')
  end
end
