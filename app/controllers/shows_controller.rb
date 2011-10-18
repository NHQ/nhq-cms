class ShowsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_show, :except => [ :index, :new, :create, :remove_review]
  
  
  def index
    @show_page = Page.where(title: "Shows").first
    index!
  end
  
  def show
    @reviews = @show.reviews
    if user_signed_in?
      @review = Review.new
      @credit = Credit.new
      @flickr = Flickr.new
      @video = Video.new
    end
  end
  
  def update
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
    @show = Show.where(:slug => params[:show_id]).first
    @review = Review.find(params[:review_id])
    @show.review_ids = @show.review_ids - [@review.id] 
    if @show.save
      flash[:notice] = "Successfully removed review."
      redirect_to @show
    else
      redirect_to @show
    end
  end
  
  private 
  
  def find_show
    @show = Show.where(:slug => params[:id]).first
  end
  
end
