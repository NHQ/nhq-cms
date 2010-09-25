module ApplicationHelper
  def remove_record_link(link_text)
    link_to(link_text, "javascript:void(0)", :class => "remove_record")
  end

  def add_record_link(link_text, model)
    link_to(link_text, "javascript:void(0)", :class => "add_record", :"data-model" => model.downcase)
  end

  def new_fields_template(model, options = {})
    options[:object]  ||= Object.const_get(model).new
    lowercase_model_name = model.downcase
    options[:partial] ||= lowercase_model_name  

    content_tag(:div, :id => "#{lowercase_model_name}_fields_template", :style => "display: none") do
      semantic_fields_for("#{lowercase_model_name.pluralize}[new-id-here]", options[:object]) do |f|
        render(:partial => options[:partial], :locals => {:f => f, :offer_remove => true})
      end
    end
  end
end
