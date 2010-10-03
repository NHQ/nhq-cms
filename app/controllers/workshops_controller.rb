class WorkshopsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]

  def show
    @workshop = Workshop.find(params[:id])
    @reviews = @workshop.reviews
  end

end