class Users::SessionsController < Devise::SessionsController
 
  def redirect_sign_in
    redirect_to '/users/sign_in'
  end

  def create
    super
    if current_user.present?
    # raise params.inspect

      cookies.permanent[:authentication_user] = Base64.encode64(current_user.email.to_s.strip)
      cookies.permanent[:authentication_token] = current_user.authentication_token
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super
    cookies.delete(:authentication_user)
    cookies.delete(:authentication_token)
  end

  protected
  def respond_with(resource, _opts = {})
    if current_user.present?
      render json: resource.as_json(except: [:jti, :gauth_tmp_datetime]).merge(organization_status: current_user.organization.status)
    end
  end
end