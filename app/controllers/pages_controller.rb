class PagesController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:show, :home]
  before_filter :find_page, :except => [ :index, :new, :create ]

  def home
    # @upcoming_events = Event.where(:title => /^F/)
    # @upcoming_events = Event.limit(2)
    # @upcoming_events = Event.where(:start_date.gte => Time.now.to_i)
    if user_signed_in?
      @video = Video.new
    end
    @all_events = Event.all
    @upcoming_events = []
    @all_events.each do |event|
      event.showdates.each do |showdate|
        if (showdate.mongo_start_time > Time.now.to_i)
          @upcoming_events << event
          break
        end
      end
    end
    @promotions = Promotion.all
  end

  def show
    if user_signed_in?
      @flickr = Flickr.new
      @video = Video.new
    end
  end
  
  def edit
  end
  
  def update
    if @page.update_attributes(params[:page])
      flash[:notice] = "successfully updated page."
      redirect_to @page
    else
      render :action => 'edit'
    end
  end

  def destroy
    @page.destroy
    flash[:notice] = "Successfully destroyed page."
    redirect_to pages_url
  end
  
  private 
  
  def find_page
    @page = Page.where(:slug => params[:id]).first
  end
  
end
