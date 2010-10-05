class ShowdatesController < InheritedResources::Base
  belongs_to :event
  actions :index, :new, :create, :destroy
  
  def create
    @event = Event.find(params[:event_id])

    # MONGOID event embeds_many showdates
    @showdate = Showdate.new(params[:showdate])
    @event.showdates << @showdate

    if @event.save
      flash[:notice] = "Date added."
      redirect_to parent_url
    else
      flash[:notice] = "Date couldn't be added."
      redirect_to parent_url
    end
  end
  
  def destroy
    destroy!(:notice => "Date removed.") {event_url(@event)}
  end

  
end
