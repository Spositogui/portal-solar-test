class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = PowerGenerator.all
  end

  def show; end
end
