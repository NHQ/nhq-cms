class ShowdatesController < InheritedResources::Base
  belongs_to :event
  actions :index, :new, :create, :destroy
  before_filter :find_event, :except => [:index]
  
  def create

    begin
      require 'date'
      require 'date/format.rb'
      date_parse_fmt = '%m/%d/%Y'
      date_fmt = '%Y-%m-%d'
      time_parse_fmt = '%I:%M%P'
      time_fmt = '%H:%M:00'
      start_date = Date.strptime(params[:showdate][:start_date], date_parse_fmt).strftime(date_fmt)
      start_time = Time.strptime(params[:showdate][:start_time], time_parse_fmt).strftime(time_fmt)
      end_date = Date.strptime(params[:showdate][:end_date], date_parse_fmt).strftime(date_fmt)
      end_time = Time.strptime(params[:showdate][:end_time], time_parse_fmt).strftime(time_fmt)
      # subtract 2 hours (convert from CST to PST)
      g_start_hour = Time.strptime(start_time, time_fmt).strftime('%H').to_i - 2
      g_start_minute = Time.strptime(start_time, time_fmt).strftime('%M:00')
      g_start_time = ("%02d" % g_start_hour).to_s + ':' + g_start_minute.to_s
      g_end_hour = Time.strptime(end_time, time_fmt).strftime('%H').to_i - 2
      g_end_minute = Time.strptime(end_time, time_fmt).strftime('%M:00')
      g_end_time = ("%02d" % g_end_hour).to_s + ':' + g_end_minute.to_s
      g_start = start_date.to_s + 'T' + g_start_time
      g_end = end_date.to_s + 'T' + g_end_time

      # MONGOID event embeds_many showdates
      #    @showdate = Showdate.new(params[:showdate])
      @showdate = Showdate.new( :start_date => start_date, 
                                :start_time => start_time, 
                                :end_date => end_date, 
                                :end_time => end_time, 
                                :g_start => g_start, 
                                :g_end => g_end)
      @event.showdates << @showdate

      if @event.save
        flash[:notice] = "Date added."
        redirect_to parent_url
      else
        flash[:notice] = "Date could not be added.  Please try again."
        redirect_to parent_url
      end
    rescue
      flash[:notice] = "Date was not added.  Both Start and End fields are required."
      redirect_to parent_url
    end
  end
  
  def destroy
    destroy!(:notice => "Date removed.") {event_url(@event)}
  end

  private
  
  def find_event
    @event = Event.first(:conditions => { :slug => params[:event_id] })  
  end
  
end
