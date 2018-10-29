class WelcomeController < ApplicationController
  def index
    @wikis = Wiki.all
    @user = current_user

  end

  def about
  end
end
