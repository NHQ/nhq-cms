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
  
  
  def mongo_start_time
    Time.parse([self.start_date, self.start_time].join(" ")).to_i
  end
  # 
  # class << self
  #   def future
  #     criteria.where(:end_date.gte => Time.now) 
  #   end
  #   def past
  #     criteria.where(:end_date.lte => Time.now)
  #   end
  # end
  
end
