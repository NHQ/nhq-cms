class Showdate
  include Mongoid::Document
  field :start_date
  field :end_date
  field :start_time
  field :end_time
  field :g_start
  field :g_end
  
  embedded_in :event, :inverse_of => :showdates

  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_presence_of :start_time
  validates_presence_of :end_time
  
end
