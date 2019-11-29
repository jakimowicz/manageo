module Manageo::Subscription
  def infos
    Manageo.get 'subscription/v1/infos'
  end

  def consumption
    Manageo.get 'subscription/v1/consommationperiod'
  end

  module_function :infos, :consumption
end
