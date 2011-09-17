class VideosController < InheritedResources::Base
  actions :new, :create, :destroy

  def create
    @video = Video.new(params[:video])

    # adding to Show, Event, Workshop, or Page
    if (params[:show_id])
      @show = Show.first(:conditions => { :slug => params[:show_id] } )
      @show.videos << @video
      @show.save
    elsif (params[:workshop_id])
      @workshop = Workshop.first(:conditions => { :slug => params[:workshop_id] } )
      @workshop.videos << @video
      @workshop.save
    elsif (params[:event_id])
      @event = Event.first(:conditions => { :slug => params[:event_id] } )
      @event.videos << @video
      @event.save
    elsif (params[:promotion_id])
      @promotion = Promotion.find(params[:promotion_id])
      @promotion.videos << @video
      @promotion.save
    elsif (params[:page_id])
      @page = Page.first(:conditions => { :slug => params[:page_id] } )
      @page.videos << @video
      @page.save
    end
    render :template => "videos/create.js.erb", :content_type => 'text/javascript'
  end
  
  def destroy
    if (params[:show_id])
      # @parent = Show.first(:conditions => { :slug => params[:show_id] } )
      @parent = Show.where(slug: params[:show_id]).first
      redirection = show_url(@parent)      
    elsif (params[:workshop_id])
      @parent = Workshop.where(slug: params[:workshop_id]).first
      redirection = workshop_url(@parent)
    elsif (params[:event_id])
      @parent = Event.where(slug: params[:event_id]).first
      redirection = event_url(@parent)
    elsif (params[:page_id])
      @parent = Page.where(slug: params[:page_id]).first
      redirection = page_url(@parent)
    elsif (params[:promotion_id])
      @parent = Promotion.find(params[:promotion_id])
      redirection = root_url
    end
    @parent.videos.where(_id: params[:id]).delete_all
    flash[:notice] = "Video removed."
    redirect_to redirection
  end
  
end
