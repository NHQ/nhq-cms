class ReviewsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_show, :only => [:new, :edit, :create]
  before_filter :find_workshop, :only => [:new, :edit, :create]
#  rescue_from Mongoid::Errors::DocumentNotFound, :with => :bad_record


  def bad_record
    render 'cleanup'
  end

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
        redirect_to reviews_url
      end
    else
      flash[:error] = "Review must have a title."
      if @show
        redirect_to @show
      elsif @workshop
        redirect_to @workshop
      else
        redirect_to reviews_url
      end
    end
  end

  def update
    if params[:show_id]
      update!(:notice => "Successfully updated Review.") { show_url(params[:show_id]) }
    elsif params[:workshop_id]
      update!(:notice => "Successfully updated Review.") { workshop_url(params[:workshop_id]) }
    else
      update!(:notice => "Successfully updated Review.") { reviews_url }
    end
  end


  private
  
  def find_show
    @show = Show.first(:conditions => { :slug => params[:show_id] })
  end

  def find_workshop
    @workshop = Workshop.first(:conditions => { :slug => params[:workshop_id] })
  end


end
