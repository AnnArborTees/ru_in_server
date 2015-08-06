class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # TODO try this shit out
  def create
    @user = User.find_for_authentication(email: params[:email])
    if @user.nil? || !@user.valid_password?(params[:password])
      render json: { errors: { password: ['does not match'] } }
    else
      render json: @user.to_json
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
