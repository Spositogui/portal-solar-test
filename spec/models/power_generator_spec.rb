require 'rails_helper'

describe PowerGenerator do
  context '.advanced_search_pg' do
    it 'successfully' do
      create(:power_generator, name: 'TRIFÁSICO A', manufacturer: 'WEG',
                               price: 39_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO B', manufacturer: 'WEG',
                               price: 49_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO C', manufacturer: 'Solar Group',
                               price: 48_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO D', manufacturer: 'WEG',
                               price: 50_000.0, structure_type: :fibrocimento)
      create(:power_generator, name: 'TRIFÁSICO E', manufacturer: 'WEG',
                               price: 60_000.0, structure_type: :metalico)

      result = PowerGenerator.advanced_search_pg('WEG', 50_000, 40_000,
                                                 'Metalico')

      expect(result.count).to eq(1)
      expect(result[0].name).to eq('TRIFÁSICO B')
    end

    it 'and return gerators only by manufacturer search' do
      create(:power_generator, name: 'TRIFÁSICO A', manufacturer: 'WEG',
                               price: 39_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO B', manufacturer: 'WEG',
                               price: 49_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO C', manufacturer: 'Solar Group',
                               price: 48_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO D', manufacturer: 'WEG',
                               price: 50_000.0, structure_type: :fibrocimento)
      create(:power_generator, name: 'TRIFÁSICO E', manufacturer: 'WEG',
                               price: 60_000.0, structure_type: :metalico)

      result = PowerGenerator.advanced_search_pg('Solar group', '', '', '')

      expect(result.count).to eq(1)
      expect(result[0].name).to eq('TRIFÁSICO C')
    end

    it 'and return gerators only by max price search' do
      create(:power_generator, name: 'TRIFÁSICO A', manufacturer: 'WEG',
                               price: 39_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO B', manufacturer: 'WEG',
                               price: 49_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO C', manufacturer: 'Solar Group',
                               price: 48_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO D', manufacturer: 'WEG',
                               price: 50_000.0, structure_type: :fibrocimento)
      create(:power_generator, name: 'TRIFÁSICO E', manufacturer: 'WEG',
                               price: 60_000.0, structure_type: :metalico)

      result = PowerGenerator.advanced_search_pg('', 50_000, '', '')

      expect(result.count).to eq(4)
      expect(result[0].name).to eq('TRIFÁSICO A')
      expect(result[1].name).to eq('TRIFÁSICO B')
      expect(result[2].name).to eq('TRIFÁSICO C')
      expect(result[3].name).to eq('TRIFÁSICO D')
    end

    it 'and return gerators only by min price search' do
      create(:power_generator, name: 'TRIFÁSICO A', manufacturer: 'WEG',
                               price: 39_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO B', manufacturer: 'WEG',
                               price: 49_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO C', manufacturer: 'Solar Group',
                               price: 48_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO D', manufacturer: 'WEG',
                               price: 50_000.0, structure_type: :fibrocimento)
      create(:power_generator, name: 'TRIFÁSICO E', manufacturer: 'WEG',
                               price: 60_000.0, structure_type: :metalico)

      result = PowerGenerator.advanced_search_pg('', '', 51_990, '')

      expect(result.count).to eq(1)
      expect(result[0].name).to eq('TRIFÁSICO E')
    end

    it 'and return gerators matched with manufacturer and structure type' do
      create(:power_generator, name: 'TRIFÁSICO A', manufacturer: 'Solar Group',
                               price: 39_990.0, structure_type: :fibrocimento)
      create(:power_generator, name: 'TRIFÁSICO B', manufacturer: 'WEG',
                               price: 49_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO C', manufacturer: 'Solar Group',
                               price: 48_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO D', manufacturer: 'WEG',
                               price: 50_000.0, structure_type: :fibrocimento)
      create(:power_generator, name: 'TRIFÁSICO E', manufacturer: 'WEG',
                               price: 60_000.0, structure_type: :metalico)

      result = PowerGenerator.advanced_search_pg('Solar Group', '', '',
                                                 'Fibrocimento')

      expect(result.count).to eq(1)
      expect(result[0].name).to eq('TRIFÁSICO A')
    end

    it 'and return gerators only by structure type search' do
      create(:power_generator, name: 'TRIFÁSICO A', manufacturer: 'WEG',
                               price: 39_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO B', manufacturer: 'WEG',
                               price: 49_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO C', manufacturer: 'Solar Group',
                               price: 48_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO D', manufacturer: 'WEG',
                               price: 50_000.0, structure_type: :fibrocimento)
      create(:power_generator, name: 'TRIFÁSICO E', manufacturer: 'WEG',
                               price: 60_000.0, structure_type: :metalico)

      result = PowerGenerator.advanced_search_pg('', '', '', 'Fibrocimento')

      expect(result.count).to eq(1)
      expect(result[0].name).to eq('TRIFÁSICO D')
    end

    it 'and return all products if any field was fill in' do
      create(:power_generator, name: 'TRIFÁSICO A', manufacturer: 'WEG',
                               price: 39_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO B', manufacturer: 'WEG',
                               price: 49_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO C', manufacturer: 'Solar Group',
                               price: 48_990.0, structure_type: :metalico)
      create(:power_generator, name: 'TRIFÁSICO D', manufacturer: 'WEG',
                               price: 50_000.0, structure_type: :fibrocimento)
      create(:power_generator, name: 'TRIFÁSICO E', manufacturer: 'WEG',
                               price: 60_000.0, structure_type: :metalico)

      result = PowerGenerator.advanced_search_pg('', '', '', '')

      expect(result.count).to eq(5)
      expect(result[0].name).to eq('TRIFÁSICO A')
      expect(result[1].name).to eq('TRIFÁSICO B')
      expect(result[2].name).to eq('TRIFÁSICO C')
      expect(result[3].name).to eq('TRIFÁSICO D')
      expect(result[4].name).to eq('TRIFÁSICO E')
    end
  end
end
