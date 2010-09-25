class Showdate
  include Mongoid::Document
  field :start_date
  
  embedded_in :event, :inverse_of => :showdates

  validates_presence_of :start_date
end
