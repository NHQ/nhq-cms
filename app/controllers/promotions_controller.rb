class PromotionsController < InheritedResources::Base
  actions :new, :create, :edit, :update, :destroy
  before_filter :authenticate_user!, :only => [:edit, :update, :new, :create, :destroy]

  def new
    new! { root_url }
  end 
  
  def index
    @promotions = Promotion.all
    @video = Video.new
  end
  
  def create
    create! { root_url }
  end
  
  def edit
    edit! { root_url }
  end

  def update
    update! { root_url }
  end
  
  def destroy
    destroy! { root_url }
  end

end
