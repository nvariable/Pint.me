class AuthorizationsController < ApplicationController
  # Create a new user or add an auth to existing user, depending on
  # whether there is already a user signed in.
  def create
    auth = request.env['omniauth.auth']
    if @auth = Authorization.find_from_hash(auth)
      @auth.user.update_token(auth)
    else
      @auth = Authorization.create_from_hash!(auth, current_user)
    end
    # Log the authorizing user in.
    self.current_user = @auth.user
    redirect_to home_dashboard_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
