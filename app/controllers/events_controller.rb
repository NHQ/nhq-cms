class EventsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def show
    @event = Event.find(params[:id])
    @showdates = @event.showdates
  end
  
end
