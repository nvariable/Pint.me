class AuthorizationsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    if @auth = Authorization.find_from_hash(auth)
      @auth.user.update_token(auth)
    else
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash!(auth, current_user)
    end
    # Log the authorizing user in.
    self.current_user = @auth.user
    
    redirect_to home_dashboard_url

  end
end
