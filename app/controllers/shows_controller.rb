class ShowsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def show
    @show = Show.find(params[:id])
    @reviews = @show.reviews
  end
  
  def add_review
    @show = Show.find(params[:id])
    @review = Review.new(params[:review])
    if @review.save
      @show.reviews = [@review]
      flash[:notice] = "Review added."
      render :action => 'show'
    else
      render :action => 'show'
    end
  end
  
end
