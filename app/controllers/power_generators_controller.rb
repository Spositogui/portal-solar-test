class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = PowerGenerator.all
  end

  def show; end

  def simple_search
    text = I18n.transliterate(params[:q])
    @power_generators = PowerGenerator.simple_search_pg(text).uniq
    render 'simple_search.js.erb'
  end
end
