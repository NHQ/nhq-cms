class EventsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def show
    @event = Event.find(params[:id])
    @showdates = @event.showdates
    @showdate = Showdate.new
    @venue = @event.venues.first
  end


  def update
    @event = Event.find(params[:id])
    if params[:venue_id]
      @venue = Venue.find(params[:venue_id])
      @event.venues << @venue
      flash[:notice] = "Added venue."
      redirect_to @event      
    elsif @event.update_attributes(params[:event])
      flash[:notice] = "Updated event."
      redirect_to @event
    else
      render :action => 'edit'
    end
  end

  
  # def add_venue
  #   @event = Event.find(params[:event_id])
  #   @venue = Venue.find(params[:venue_id])
  #   @event.venue_ids = @event.venue_ids + [@venue.id] 
  #   if @event.save
  #     flash[:notice] = "Successfully added venue."
  #     redirect_to @event
  #   else
  #     redirect_to @event
  #   end
  # end
  
  def remove_venue
    @event = Event.find(params[:event_id])
    @venue = Venue.find(params[:venue_id])
    @event.venue_ids = @event.venue_ids - [@venue.id] 
    if @event.save
      flash[:notice] = "Successfully removed venue."
      redirect_to @event
    else
      redirect_to @event
    end
  end
  
  
end
