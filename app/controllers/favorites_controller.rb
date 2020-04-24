class FavoritesController < ApplicationController
  before_action :require_user_logged_in
    
  def create
    binding.pry
    current_user.like(params[:micropost])
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
  end
end