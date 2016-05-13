class Wiki < ActiveRecord::Base
  belongs_to :user
  
   validates :title, presence: true
   validates :body, presence: true
   validates :user, presence: true
   
   scope :visible_to, -> (user) { ((user.role == "admin") || (user.role == "premium")) ? all : where(private: false) }
end
