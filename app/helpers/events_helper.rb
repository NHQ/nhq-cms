module EventsHelper
  # def remove_link_unless_new_record(fields)
  #   unless fields.object.new_record?
  #     out = ''
  #     out << fields.hidden_field(:_delete)
  #     out << link_to_function("remove", "$(this).up('.#{fields.object.class.name.underscore}').hide(); $(this).previous().value = '1'")
  #     out
  #   end
  # end
  # 
  # These use the current date, but they could be lots easier.
  # Maybe just keep a global counter which starts at 10 or so.
  # That would be good enough if we only build 1 new record in the controller.
  #
  # And this of course is only needed because Ryan's example uses JS to add new
  # records. If you just build a new one in the controller this is all unnecessary.
  
  # def add_showdate_link(name, form)
  #   link_to_function name do |page|
  #     showdate = render(:partial => 'showdate', :locals => { :pf => form, :showdate => OptionValue.new })
  #     page << %{
  #       var new_showdate_id = "new_" + new Date().getTime();
  #       $('showdates').insert({ bottom: "#{ escape_javascript showdate }".replace(/new_\\d+/g, new_showdate_id) });
  #     }
  #   end
  # end
  # 
  # def generate_html(form_builder, method, options = {})
  #   options[:object] ||= form_builder.object.class.reflect_on_association(method).klass.new
  #   options[:partial] ||= method.to_s.singularize
  #   options[:form_builder_local] ||= :f
  #  
  #   form_builder.fields_for(method, options[:object], :child_index => 'NEW_RECORD') do |f|
  #     render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })
  #   end
  # end
  #  
  # def generate_template(form_builder, method, options = {})
  #   escape_javascript generate_html(form_builder, method, options)
  # end
end
