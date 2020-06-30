class AdminUsersController < ApplicationController
  # instance variables defined here used in views

  layout 'admin'

  # Controller filters #
  #----------------------

  # set this for these actions inside this controller
  before_action :confirm_logged_in

  # CRUD Actions #
  #-----------------------

  def index
    @admin_users = AdminUser.sorted
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(admin_user_params)
    if @admin_user.save
      flash[:notice] = "Admin User created sucessfully."
      redirect_to(admin_users_path)
    else
      render('new')
    end
  end

  def edit
    @admin_user = AdminUser.find(params[:id])
  end

  def update
    @admin_user = AdminUser.find(params[:id])
    if @admin_user.update_attributes(admin_user_params)
      flash[:notice] = "Admin User updated successfully."
      redirect_to(admin_users_path)
    else
      render('edit')
    end
  end

  def delete
    @admin_user = AdminUser.find(params[:id])
  end

  def destroy
    @admin_user = AdminUser.find(params[:id])
    @admin_user.destroy
    flash[:notice] = "Admin User '#{@admin_user.username}' deleted successfully."
    redirect_to(admin_users_path)
  end
  private

  def admin_user_params
    params.require(:admin_user).permit(
      :first_name,
      :last_name,
      :email,
      :username,
      :password # virtual attributes. It was added  by has_secure_password
    )
  end

end
