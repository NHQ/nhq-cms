class ShowdatesController < InheritedResources::Base
  belongs_to :event
  actions :index, :new, :create, :destroy
  
  # def create
  #   @event = Event.find(params[:event_id])
  #   @showdate = @event.showdates.build(params[:showdate])
  #   if @showdate.save
  #     flash[:notice] = "Successfully created Event Date."
  #     redirect_to event_showdates_path(@event)
  #   else
  #     render :action => 'new'
  #   end
  # end 
  
  def create
    @event = Event.find(params[:event_id])
    @showdate = Showdate.new(params[:showdate])
    @event.showdates << @showdate
    if @event.save
      flash[:notice] = "Successfully created event."
      redirect_to event_path(@event)
    else
      render :action => :show
    end
  end
  
  def destroy
    destroy! {event_path(@event)}
  end

  
end
