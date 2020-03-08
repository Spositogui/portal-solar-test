class PowerGenerator < ApplicationRecord
  validates :name, :description, :image_url, :manufacturer, :price, :kwp,
            presence: true
  validates :height, numericality: { greater_than_or_equal_to: 0,
                                     less_than_or_equal_to: 40 }
  validates :width, numericality: { greater_than_or_equal_to: 0,
                                    less_than_or_equal_to: 100 }
  validates :lenght, numericality: { greater_than_or_equal_to: 0,
                                     less_than_or_equal_to: 200 }
  validates :weight, numericality: { greater_than_or_equal_to: 0,
                                     less_than_or_equal_to: 3000 }

  enum structure_type: { metalico: 0, ceramico: 1, fibrocimento: 2, laje: 3,
                         solo: 4, trapezoidal: 5 }

  scope :simple_search_pg, lambda { |text|
    where('unaccent(name) ILIKE :q OR unaccent(description) ILIKE :q',
          q: "%#{text}%")
  }

  def self.advanced_search_pg(facturer, p_max, p_min, s_type)
    p_min = 0 if p_min.blank?
    p_max = 999_999.999 if p_max.blank?
    return as_without_facturer(p_max, p_min, s_type) if facturer.blank?
    return as_without_type(facturer, p_max, p_min) if s_type.blank?

    where('manufacturer ILIKE ? AND price <= ? AND price >= ? AND '\
          'structure_type = ?', facturer, p_max, p_min,
          structure_types[s_type.downcase])
  end

  def self.as_without_facturer(p_max, p_min, s_type)
    return where('price <= ? AND price >= ?', p_max, p_min ) if s_type.blank?

    where('price <= ? AND price >= ? AND structure_type = ?',
          p_max, p_min, structure_types[s_type.downcase])
  end

  def self.as_without_type(facturer, p_max, p_min)
    where('manufacturer ILIKE ? AND price <= ? AND price >= ?',
          facturer, p_max, p_min)
  end

  private_class_method :as_without_facturer, :as_without_type
end
