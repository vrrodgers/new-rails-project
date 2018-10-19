class WikisController < ApplicationController
  before_action :set_wiki, only:[:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  def index
    @user = User.find_by(id: session[:user_id])
    @wiki = Wiki.all
  end

  def show
   
  end

  def new
    @wiki = current_user.wikis.build

  end

  def create
    @wiki = current_user.wikis.build(wiki_params)

     #@wiki.user = current_user
    
     if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
     else
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :new
      end
    end

  def edit
  end
  
  def update
    @wiki.update(wiki_params)
     if @wiki.save
       flash[:notice] = "Wiki was updated."
        redirect_to @wiki

     else
       flash.now[:alert] = "There was an error saving your wiki. Please try again."
       render :edit
     end
  end

   def destroy
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
        redirect_to @wiki
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end
   end

    private
    def wiki_params
      params.require(:wiki).permit(:title, :body)
    end
    def set_wiki
      @wiki = Wiki.find(params[:id])
    end

    def authorize_user
      wiki = Wiki.find(params[:id])
       unless current_user == wiki.user #|| current_user.admin?
        flash[:alert] = "You must be a current user to do that."
        redirect_to wiki
      end
    end
end