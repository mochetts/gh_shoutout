class AffinitiesController < ApiController
  
  def index
    render json: affinities.to_json
  end

private

  def affinities
    AffinitiesSquasherService.for(filters[:user]).squash(**date_filters)
  end

  def date_filters
    filters.slice(:from, :to).to_hash.symbolize_keys
  end

  def filters
    params.permit(:user, :from, :to)
  end
end
