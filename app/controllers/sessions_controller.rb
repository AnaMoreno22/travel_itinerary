class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to root_path
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
