class FreightsController < ApplicationController
  def freight_value
    @response = CalculateFreight.value(params[:q])
    render 'freights/freight_value.js.erb'
  end
end
