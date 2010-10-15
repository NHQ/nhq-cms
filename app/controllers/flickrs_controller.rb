class FlickrsController < InheritedResources::Base
  belongs_to :show
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

    photoset = flickr.photosets.getInfo( :photoset_id => params[:photoset_id])

    phs = flickr.photosets.getPhotos( :photoset_id => params[:photoset_id], 
                                      :extras => 'url_sq').to_hash["photo"]

    # get photo urls
    photos = phs.map {|photo| photo["url_sq"]}

    p = photoset.to_hash.merge({:type => "flickr photoset",
                                :photos => photos,
                                :photoset_id => params[:photoset_id],
                                :id => nil
                              })

    @flickr = Flickr.new(p)

    # assume this is for SHOW, for now
    @show = Show.find(params[:show_id])
    @show.flickrs << @flickr

    if @flickr.save
      flash[:notice] = "Photoset added."
      redirect_to parent_url
    else
      flash[:error] = "Unable to add photoset."
      redirect_to parent_url
    end
  end
  
  def destroy
    destroy!(:notice => "Photoset removed.") {show_url(@show)}
  end
  
end