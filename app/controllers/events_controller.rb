class EventsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show, :feed]
  before_filter :find_event, :except => [ :index, :new, :create, :feed ]
  
  def show
    @venue = @event.venues.first
    @showdates = @event.showdates.ascending(:start_date)
    if user_signed_in?
      @showdate = Showdate.new
      @flickr = Flickr.new
      @video = Video.new
    end
  end
  
  def feed
  end

  def index
    @upcoming_page = Page.where(title: "Upcoming").first
    index!
  end

  def update
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
    @event = Event.where(:slug => params[:event_id]).first
    @venue = Venue.find(params[:venue_id])
    @event.venue_ids = @event.venue_ids - [@venue.id] 
    if @event.save
      flash[:notice] = "Successfully removed venue."
      redirect_to @event
    else
      redirect_to @event
    end
  end
  
  private 
  
  def find_event
    @event = Event.where(:slug => params[:id]).first
  end
  
end
