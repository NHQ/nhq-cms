class EventsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show, :feed]
  
  def show
    @event = Event.find(params[:id])
    @venue = @event.venues.first
    @showdates = @event.showdates.ascending(:start_date)
    if user_signed_in?
      @showdate = Showdate.new
      @flickr = Flickr.new
    end
  end
  
  def feed
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
