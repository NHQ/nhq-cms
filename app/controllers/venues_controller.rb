class VenuesController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_event, :only => [:new, :edit, :create, :update]
  before_filter :find_venue, :except => [ :index, :new, :create, :feed ]

  def create
    @venue = Venue.new(params[:venue])
    if @venue.save
      flash[:notice] = "Successfully created venue."
      if @event
        @event.venues << @venue
        redirect_to @event
      else
        redirect_to @venue
      end
    else
      flash[:error] = "Venue must have a title."
      if @event
        redirect_to @event
      else
        redirect_to @venue
      end
    end
  end
  
  def update
    @venue = Venue.find(params[:id])
    if @venue.update_attributes(params[:venue])
      flash[:notice] = "Successfully updated venue."
      if @event
        redirect_to @event
      else
        redirect_to @venue
      end
    else
      render :action => 'edit'
    end
  end


  private
  
  def find_event
    @event = Event.first(:conditions => { :slug => params[:event_id] } )
  end
  
  def find_venue
    @venue = Venue.first(:conditions => { :slug => params[:id] } )
  end

end
