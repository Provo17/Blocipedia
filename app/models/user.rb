class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         

  
  has_many :created_wikis, dependent: :destroy, class_name: "Wiki"

  has_many :collaborations
  has_many :collaborating_wikis, through: :collaborations, class_name: "Wiki", source: :wiki
  
  before_save {self.email = email.downcase}
  after_initialize { self.role ||= :standard}  
  enum role: [:standard, :premium, :admin]
  
  def downgrade!
    self.role = 'standard'
    self.save
    if self.role == "standard"
      make_wikis_public
    else
      redirect_to root_path
      flash[:alert] = "There was an error downgrading your account, please try again."
    end
  end

  def make_wikis_public
    wikis.each do |wiki|
      wiki.update_attributes!(private: false)
    end
  end
end
