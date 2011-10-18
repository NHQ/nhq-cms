class WorkshopsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_workshop, :except => [ :index, :new, :create, :remove_review ]

  def show
    @reviews = @workshop.reviews
    if user_signed_in?
      @flickr = Flickr.new
      @video = Video.new
    end
  end

  def index
    @workshops_page = Page.where(title: "Workshops").first
    index!
  end

  def update
    if params[:review_id]
      @review = Review.find(params[:review_id])
      @workshop.reviews << @review
      flash[:notice] = "Successfully added review."
      redirect_to @workshop      
    elsif @workshop.update_attributes(params[:workshop])
      flash[:notice] = "Successfully updated workshop."
      redirect_to @workshop
    else
      render :action => 'edit'
    end
  end
  
  def remove_review
    @workshop = Workshop.where(:slug => params[:workshop_id]).first
    @review = Review.find(params[:review_id])
    @workshop.review_ids = @workshop.review_ids - [@review.id] 
    if @workshop.save
      flash[:notice] = "Successfully removed review."
      redirect_to @workshop
    else
      redirect_to @workshop
    end
  end
  
  
  
  private 
  
  def find_workshop
    @workshop = Workshop.where(:slug => params[:id]).first
  end

end