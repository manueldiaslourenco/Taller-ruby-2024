# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  def edit
     super
  end

  # PUT /resource
  def update
    if @user.valid_password?(account_update_params[:current_password])
      if @user.update(account_update_params.except(:current_password))
        flash[:notice] = "Usuario actualizado correctamente."
        if account_update_params[:password].present?
          flash[:notice] = "Se debe volver a iniciar sesión luego de cambiar la contraseña."
        end
        redirect_to after_update_path_for(@user)
      else
        if @user.errors.any?
          flash_messages_from_model(@user)
        end
        render :edit, status: :unprocessable_entity
      end
    else
      flash.now[:error] = "La contraseña actual es incorrecta."
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :phone])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :phone, :current_password, :password, :password_confirmation])
  end
  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

end
