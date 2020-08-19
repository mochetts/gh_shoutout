class AffinitiesController < ApiController
  
  def index
    render json: affinities.to_json
  end

private

  def affinities
    AffinitiesSquasherService.for(params[:user]).squash(**date_range)
  end

  def date_range
    params.require(:date_range).permit(:from, :to).to_hash.symbolize_keys
  end
end
