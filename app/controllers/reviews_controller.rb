class ReviewsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_show, :only => [:new, :edit, :create]
  before_filter :find_workshop, :only => [:new, :edit, :create]


  def create
    @review = Review.new(params[:review])
    if @review.save
      flash[:notice] = "Successfully created review."
      if @show
        @show.reviews << @review
        redirect_to @show
      elsif @workshop
        @workshop.reviews << @review
        redirect_to @workshop
      else
        redirect_to @review
      end
    else
      flash[:error] = "Review must have a title."
      if @show
        redirect_to @show
      elsif @workshop
        redirect_to @workshop
      else
        redirect_to @review
      end
    end
  end

  private
  
  def find_show
    @show = Show.criteria.id(params[:show_id]).first
  end

  def find_workshop
    @workshop = Workshop.criteria.id(params[:workshop_id]).first
  end


end
