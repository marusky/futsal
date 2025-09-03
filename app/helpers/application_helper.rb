module ApplicationHelper
  def with_params(query_params)
    request.query_parameters.slice(:order_by, :score_type).merge(query_params)
  end
end
