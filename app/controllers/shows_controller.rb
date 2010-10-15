class ShowsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def show
    @show = Show.find(params[:id])
    @reviews = @show.reviews
    @review = Review.new
    @credit = Credit.new
    @flickr = Flickr.new
  end
  
  def update
    @show = Show.find(params[:id])
    if params[:review_id]
      @review = Review.find(params[:review_id])
      @show.reviews << @review
      flash[:notice] = "Successfully added review."
      redirect_to @show      
    elsif params[:flickr_id]
      @flickr = Flickr.find(params[:flickr_id])
      @show.flickrs << @flickr
      flash[:notice] = "Successfully added photoset."
      redirect_to @show
    elsif @show.update_attributes(params[:show])
      flash[:notice] = "Successfully updated show."
      redirect_to @show
    else
      render :action => 'edit'
    end
  end
  
  def add_review
    @show = Show.find(params[:id])
    @review = Review.find(params[:review_id])
    if @show.reviews << @review
      flash[:notice] = "Successfully added review."
      redirect_to @show
    else
      redirect_to @show
    end
  end
  
end
