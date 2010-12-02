class FlickrsController < InheritedResources::Base
  actions :index, :show, :refetch, :create, :destroy
  
  def index
    @flickrs = Flickr.desc(:photoset_id)
  end
  
  def refetch
    Flickr.fetch_photoset_list
    flash[:notice] = "successfully re-fetched photos."
    redirect_to flickrs_url
  end
  
  def create

    @flickr = Flickr.new
    
    photoset = flickr.photosets.getInfo( :photoset_id => params[:photoset_id])

    phs = flickr.photosets.getPhotos( :photoset_id => params[:photoset_id], 
                                      :extras => "url_m").to_hash["photo"]

    # get photo urls
    photos = phs.map {|photo| photo["url_m"].gsub(".jpg", "")}
    
    p = photoset.to_hash.merge({:type => "flickr photoset",
                                :photos => photos,
                                :photoset_id => params[:photoset_id],
                                :id => nil
                              })

    @photoset = Flickr.new(p)

    # adding to Show, Event, Workshop, or Page
    if (params[:show_id])
      @show = Show.first(:conditions => { :slug => params[:show_id] })
      @show.flickrs << @photoset
      @show.save
    elsif (params[:workshop_id])
      @workshop = Workshop.first(:conditions => { :slug => params[:workshop_id] })
      @workshop.flickrs << @photoset
      @workshop.save
    elsif (params[:event_id])
      @event = Event.first(:conditions => { :slug => params[:event_id] })
      @event.flickrs << @photoset
      @event.save      
    elsif (params[:page_id])
      @page = Page.first(:conditions => { :slug => params[:page_id] })
      @page.flickrs << @photoset
      @page.save
    end
    render :template => "flickrs/create.js.erb", :content_type => 'text/javascript'
  end
  
  def destroy
    if (params[:show_id])
      @parent = Show.first(:conditions => { :slug => params[:show_id] })
      redirection = show_url(@parent)
    elsif (params[:workshop_id])
      @parent = Workshop.first(:conditions => { :slug => params[:workshop_id] })
      redirection = workshop_url(@parent)
    elsif (params[:event_id])
      @parent = Event.first(:conditions => { :slug => params[:event_id] })
      redirection = event_url(@parent)
    elsif (params[:page_id])
      @parent = Page.first(:conditions => { :slug => params[:page_id] })
      redirection = page_url(@parent)
    end
    @flickr = @parent.flickrs.criteria.id(params[:id]).first
    @flickr.destroy
    flash[:notice] = "Photoset removed."
    redirect_to redirection
  end
  
end