class CalculateFreight
  attr_reader :freight_value

  NORTH = %w[AM RR AP PA TO RO AC].freeze
  NORTHEAST = %w[MA PI CE RN PE PB SE AL BA].freeze
  MIDWEST = %w[MT MS GO DF].freeze
  SOUTHEAST = %w[SP RJ ES MG].freeze
  SOUTH = %w[PR RS SC].freeze

  def initialize(value)
    @freight_value = value
  end

  def self.value(cep)
    response = CepApiConsumer.query_result(cep)
    return new('Error') if response.blank?

    value = freight_calculation_by_region(response)
    register_freight_value(value)
  end

  def self.freight_calculation_by_region(estado)
    return 300.0 if NORTH.include?(estado)
    return 250.0 if NORTHEAST.include?(estado)
    return 200.0 if MIDWEST.include?(estado)
    return 100.0 if SOUTHEAST.include?(estado)

    150.0 if SOUTH.include?(uf)
  end

  def self.register_freight_value(value)
    new(value)
  end

  private_class_method :new, :freight_calculation_by_region,
                       :register_freight_value
end
