class UsersController < ApplicationController
 
 def downgrade
   if current_user.role == 'premium'
      current_user.downgrade!
     flash[:notice] = "Premium membership cancelled successfully."
     redirect_to wikis_path
   else
     flash.now[:alert] = "There was an error cancelling your premium membership."
     redirect_to wikis_path
   end
 end
end
