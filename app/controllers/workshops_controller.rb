class WorkshopsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]

  def show
    @workshop = Workshop.find(params[:id])
    @reviews = @workshop.reviews
  end

  def update
    @workshop = Workshop.find(params[:id])
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


end