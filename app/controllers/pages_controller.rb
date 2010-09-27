class PagesController < InheritedResources::Base
  before_filter :find_page, :except => [ :index, :new, :create ]

  def show
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