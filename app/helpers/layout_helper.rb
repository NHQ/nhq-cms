# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  
  def body_id(name)
    content_for(:body_id){name}
  end
  
  def yield_for(content_sym, default)
    output = content_for(content_sym)
    output = default if output.blank?
    output
  end
  
  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end
  
  def javascript(*args)
    args = args.map { |arg| arg == :defaults ? arg : arg.to_s }
    content_for(:javascripts) { javascript_include_tag(*args) }
  end

  def flickr_src(base_url, size)
    if size=='m'
      return base_url + '.jpg'
    else
      return base_url + '_' + size + '.jpg'
    end
  end
  
  def pretty_url(url)
    url.gsub("http://", "")
  end
end
