class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :registerable, and :timeoutable
  # devise :database_authenticatable, :trackable, :validatable, :oauthable
  devise :database_authenticatable, :trackable, :validatable

  field :name
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false
  attr_accessible :name, :email, :password, :password_confirmation
end
