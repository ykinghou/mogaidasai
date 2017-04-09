class AccountsController < ApplicationController


  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.find(params[:id])
    @user.is_admin = true
    flash[:notice] = 'Power Add!'
  end

  def update
    @user = User.find(params[:id])
    @user.is_admin = true
    flash[:notice] = 'Power Add!'
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:alert] = 'Account Destroy!'
  end

end
