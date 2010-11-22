class VideosController < InheritedResources::Base
  actions :new, :create, :destroy

  def create
    @video = Video.new(params[:video])

    # adding to Show, Event, Workshop, or Page
    if (params[:show_id])
      @show = Show.find(params[:show_id])
      @show.videos << @video
      @show.save
      render :template => "videos/create.js.erb", :content_type => 'text/javascript'
    elsif (params[:workshop_id])
      @workshop = Workshop.find(params[:workshop_id])
      @workshop.videos << @video
      @workshop.save
      render :template => "videos/create.js.erb", :content_type => 'text/javascript'
    elsif (params[:event_id])
      @event = Event.find(params[:event_id])
      @event.videos << @video
      @event.save
      render :template => "videos/create.js.erb", :content_type => 'text/javascript'
    elsif (params[:page_id])
      @page = Page.find(params[:page_id])
      @page.videos << @video
      @page.save
      render :template => "videos/create.js.erb", :content_type => 'text/javascript'
    end
  end
  
  def destroy
    if (params[:show_id])
      @parent = Show.find(params[:show_id])
      redirection = show_url(@parent)
    elsif (params[:workshop_id])
      @parent = Workshop.find(params[:workshop_id])
      redirection = workshop_url(@parent)
    elsif (params[:event_id])
      @parent = Event.find(params[:event_id])
      redirection = event_url(@parent)
    elsif (params[:page_id])
      @parent = Page.find(params[:page_id])
      redirection = page_url(@parent)
    end
    @video = @parent.videos.criteria.id(params[:id]).first
    @video.destroy
    flash[:notice] = "Video removed."
    redirect_to redirection
  end
  
end
