class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  #validates :username, :presence => true, :uniqueness => {:case_sensitive => false}
  
  has_many :wikis
  
  before_save {self.email = email.downcase}
  after_initialize { self.role ||= :standard}  
  enum role: [:standard, :premium, :admin]
end
