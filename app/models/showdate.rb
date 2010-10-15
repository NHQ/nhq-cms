class Showdate
  include Mongoid::Document
  field :start_date, :type => Date
  field :end_date, :type => Date
  field :start_time, :type => Time
  field :end_time, :type => Time
  
  embedded_in :event, :inverse_of => :showdates

  validates_presence_of :start_date
end
