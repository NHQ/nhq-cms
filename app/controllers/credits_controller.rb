class CreditsController < InheritedResources::Base
  belongs_to :show
  actions :index, :new, :create, :destroy
  
  def create
    @show = Show.find(params[:show_id])

    # MONGOID show embeds_many credits
    @credit = Credit.new(params[:credit])
    @show.credits << @credit

    if @show.save
      flash[:notice] = "Credit added."
      redirect_to parent_url
    else
      flash[:notice] = "Credit couldn't be added."
      redirect_to parent_url
    end
  end
  
  def destroy
    destroy!(:notice => "Credit removed.") {show_url(@show)}
  end

  
end