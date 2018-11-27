class ProfilesController < ApplicationController
  def show
    set_user
    @flats = Flat.where(user_id: @user.id)
  end

  private

  def set_user
    @user = current_user
  end
end
