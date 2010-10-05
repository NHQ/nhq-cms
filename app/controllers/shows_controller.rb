class ShowsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def show
    @show = Show.find(params[:id])
    @reviews = @show.reviews
  end
  
end
