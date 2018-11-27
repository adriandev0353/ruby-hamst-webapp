class UserProfilesController < ApplicationController
  def index
    @user_profiles = UserProfile.all
  end

  def show
    @user_profile = UserProfile.find(params[:id])
  end

  def new
    @user_profile = UserProfile.new
  end

  def edit
    @user_profile = UserProfile.find(params[:id])
  end

  def create
   
    @user_profile = UserProfile.new(profile_params)
    #    @user_profile.auto_fill_username_and_account(current_user)

    if @user_profile.save
      @user_profile.update(:lend_rating=>0)
      flash[:notice] = "Profile added"
      redirect_to :root
    else
      flash[:alert] = @user_profile.errors.full_messages

      render "new"
    end
  end

  def update
    @user_profile = UserProfile.find(params[:id])
    @registerInProgress = @user_profile.birthday.nil?
    @updateResult = @user_profile.update(profile_params)

    if @updateResult && !@registerInProgress
      @user_profile.errors.clear
      flash[:notice] = "Profile updated"
      redirect_to @user_profile
    elsif @updateResult && @registerInProgress
      @user_profile.errors.clear
      flash[:notice] = "Profile added"
      redirect_to :root
    else
      flash[:error] = @user_profile.errors.full_messages.map(&:inspect).join()
      render "edit"
    end
  end

  #items that I lent to others
  def lend_to_others
    @user_profile = UserProfile.find(current_user.id)
    @items = @user_profile.items
  end

  #items that I borrowed from others
  def borrow_from_others
    @user_profile = UserProfile.find(current_user.id)
    @user_name = @user_profile.username
    @borrow_requests = @user_profile.borrow_requests
  end
  #rating other people
  def lend_rating
    @lend_person = UserProfile.find(params[:id])
    @l_rating = @lend_person.lend_rating
    @l_people = @lend_person.lpeople
    @l_people = @l_people + 1
    @l_rating = (@l_rating + params[:rating]) / @lpeople
    #:borrow_rating => @l_rating
    #:bpeople => @l_people
    if @lend_person.update(rate_params)
      redirect_to current_user
    else
      render "edit"
    end
  end
  private

  def profile_params
    params.require(:user_profile).permit(:account_id, :username, :first_name, :last_name, :birthday,:avatar, address: [:street_address, :city, :province_id, :postal_code])
  end

  def rate_params
    params.require(:user_profile).permit(:lend_rating, :lpeople)
  end
end
