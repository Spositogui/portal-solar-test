FactoryBot.define do
  factory :power_generator do
    name { 'TRIFÁSICO 380V' }
    description do
      'O APsystems YC600i com EnergyMaxTM é um microinversor grid-tie que '\
      'garante a máxima eficiência do sistema fotovoltaico. Altamente '\
      'confiável e econômico, o YC600i com EnergyMaxTM é otimizado para os '\
      'mais novos painéis fotovoltaicos de alta eficiência. O micro inversor '\
      'possui 600W de potência de saída e duplo MPPT. Com aterramento '\
      'integrado, sem a necessidade de string box e com a metade '\
      'do tempo de instalação, você economiza dinheiro e tempo.'
    end
    image_url do
      'https://marketplace-img-production.s3.amazonaws.com/products/'\
      '107646/large/Montagem_YC600.JPG?1566566821'
    end
    manufacturer { 'Solar Group' }
    price { 2958.5 }
    kwp { 0.68 }
    height { 1.1 }
    width { 0.2 }
    lenght { 2.1 }
    weight { 142 }
    structure_type { :ceramico }
  end
end
