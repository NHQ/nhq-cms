class ShowsController < InheritedResources::Base
  respond_to :html, :xml
  before_filter :authenticate_user!, :except => [:index, :show]
end
