class ConditionsOfUseController < ApplicationController
  def index
    @conditions_of_use = ConditionsOfUse.all
  end
end
