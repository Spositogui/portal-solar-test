class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = PowerGenerator.all
    @power_generators = Kaminari.paginate_array(@power_generators)
                                .page(params[:page]).per(6)
  end

  def show; end

  def advanced_search
    q = params.permit(:manufacturer, :max, :min, :structure_type)
    count = 0
    q.each { |param| count += 1 if param.blank? }
    return @power_generators = nil if count.eql?(4)

    @power_generators = PowerGenerator.advanced_search_pg(q[:manufacturer],
                                                          q[:max], q[:min],
                                                          q[:structure_type])
    render 'searches_result.js.erb'
  end

  def filter_price
    return if params[:q].blank?

    @power_generators = PowerGenerator.where('price <= ?', params[:q])
                                      .order(:name).page(params[:page]).per(6)
    render 'searches_result.js.erb'
  end

  def simple_search
    text = I18n.transliterate(params[:q])
    @power_generators = PowerGenerator.simple_search_pg(text).uniq
    render 'searches_result.js.erb'
  end
end
