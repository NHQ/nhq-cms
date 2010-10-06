class Credit
  include Mongoid::Document
  field :title
  field :name
  
  embedded_in :show, :inverse_of => :credits

  validates_presence_of :title
  validates_presence_of :name
end