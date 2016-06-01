class UsersController < ApplicationController
 
  def downgrade
    @user = current_user
    @user.update_attributes(role: 'standard')

    if @user.save
        flash[:notice] = "Account downgraded to 'Standard'"
        redirect_to wikis_path

        @user.wikis.each do |wiki|
          wiki.update_attribute(:public, true)
          end
    else
        flash[:error] = "Could not downgrade your account"
    end
  end
end
