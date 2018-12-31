class WikisController < ApplicationController
  before_action :set_wiki, only:[:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_current_user

  #after_action :verify_authorized, except: index
  #after_action :verify_policy_scoped, only: index

  def index
    @user = current_user
    @wikis = policy_scope(Wiki)
    @wikis = WikiPolicy::Scope.new(current_user, Wiki).resolve 
    @wikis = Wiki.all_public_wikis
    @own_public_wiki = @wikis.own_any_wikis
   end

  def show
    #@wiki = Wiki.find(params[:id])
    @collaborators = @wiki.collaborators
    @wiki = Wiki.find(params[:id])
    if @wiki.private?
      if @wiki.user == current_user
        wiki_path
      elsif current_user.standard?
        flash[:alert] = "You must be a premium user to view private wikis."
        redirect_to new_charge_path
      elsif @wiki.collaborators.exclude?(current_user)
        flash[:alert] = "You must be a collaborator to view that wiki."
        redirect_to wikis_path
      end
    else
      wiki_path
    end

  end

  def new
    @wiki = current_user.wikis.build
    @standard_users = User.where(role: 'standard')
    
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
     
     @wiki.user = current_user
    
     if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
     else
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :new
      end
    end

  def edit
    @standard_users = User.where(role: 'standard')
     @collaborators = @wiki.collaborators
  end
  
  def update
    @wiki.update_attributes(wiki_params)
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

   def mywiki
    @wikis = Wiki.where(user_id: current_user.id)
   end

    private
    def wiki_params
      params.require(:wiki).permit(:title, :body, :private,
                                   collaborators_attributes:[:id, :user_id, :_destroy ]   
      )
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