class ShowsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def show
    @show = Show.find(params[:id])
    @reviews = @show.reviews
    if user_signed_in?
      @review = Review.new
      @credit = Credit.new
      @flickr = Flickr.new
    end
  end
  
  def update
    @show = Show.find(params[:id])
    if params[:review_id]
      @review = Review.find(params[:review_id])
      @show.reviews << @review
      flash[:notice] = "Added review."
      redirect_to @show      
    elsif @show.update_attributes(params[:show])
      flash[:notice] = "Updated show."
      redirect_to @show
    else
      render :action => 'edit'
    end
  end
  
  # def add_review
  #   @show = Show.find(params[:show_id])
  #   @review = Review.find(params[:review_id])
  #   @show.review_ids = @show.review_ids + [@review.id] 
  #   if @show.save
  #     flash[:notice] = "Successfully added review."
  #     redirect_to @show
  #   else
  #     redirect_to @show
  #   end
  # end
  
  def remove_review
    @show = Show.find(params[:show_id])
    @review = Review.find(params[:review_id])
    @show.review_ids = @show.review_ids - [@review.id] 
    if @show.save
      flash[:notice] = "Successfully removed review."
      redirect_to @show
    else
      redirect_to @show
    end
  end
  
end
