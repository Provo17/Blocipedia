class ChargesController < ActionController::Base

  def new
    Rails.logger.info Rails.configuration.stripe.inspect
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Membership - #{current_user.email}",
     amount: 15_00
   }
  end

 def create
   # Creates a Stripe Customer object, for associating
   # with the charge
   customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
   )
 
   # Where the real magic happens
   charge = Stripe::Charge.create(
     customer: customer.id, # Note -- this is NOT the user_id in your app
     amount: 15_00,
     description: "Membership - #{current_user.email}",
     currency: 'usd'
   )
 
   flash[:notice] = "Thanks for your support, #{current_user.email}, enjoy!"
   current_user.premium!
   redirect_to wikis_path
 
   # Stripe will send back CardErrors, with friendly messages
   # when something goes wrong.
   # This `rescue block` catches and displays those errors.
   rescue Stripe::CardError => e
     flash[:alert] = e.message
     redirect_to new_charge_path
 end
end