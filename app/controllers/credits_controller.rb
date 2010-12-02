class CreditsController < InheritedResources::Base
  belongs_to :show
  actions :new, :create, :destroy
  before_filter :find_show
  
  def create
    # MONGOID show embeds_many credits
    @credit = Credit.new(params[:credit])
    @show.credits << @credit

    if @credit.save
      render :template => "credits/create.js.erb", :content_type => 'text/javascript'
    else
      flash[:error] = "Credit can't be blank."
      redirect_to parent_url
    end
  end
  
  def destroy
    destroy!(:notice => "Credit removed.") {show_url(@show)}
  end

  private
  
  def find_show
    @show = Show.first(:conditions => { :slug => params[:show_id] } )
  end
  
end