class Wiki < ActiveRecord::Base
    
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators, :source => :wiki
  
   validates :title, presence: true
   validates :body, presence: true
   validates :user, presence: true
   
   default_scope { order('created_at DESC')}
   
   scope :visible_to, -> (user) { user ? all : where(public: true) }

  #def set_private
    #self.private = true
  #end
end
