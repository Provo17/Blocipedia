class WikisController < ApplicationController
  
	#skip_before_filter :authenticate_user!, only: [:index, :show]
	#before_action :set_wiki, only: [:show, :edit, :update, :destroy]
  
  def index
    @wikis = policy_scope(Wiki)
  end

  def new
    @wiki = Wiki.new
  end
  
  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.public = params[:wiki][:public] || true
    @wiki.user = current_user
    
    if @wiki.save
      flash[:notice] = "\"#{@wiki.title}\" was created successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving wiki. Please try again."
      render :new
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
    #authorize @wiki
    
    unless @wiki.public || current_user
      flash[:alert] = "You must be signed in to view private topics."
      redirect_to new_session_path
    end    
  end


  def edit
    @wiki = Wiki.find(params[:id])
    @wiki.user = current_user
    authorize @wiki
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.public = params[:wiki][:public] if params[:wiki][:public]
    @wiki.user = current_user
    authorize @wiki
    
    if @wiki.save
      flash[:notice] = "Wiki was updated successfully"
      redirect_to @wiki
    else
      flash.now[:alret] = "There was an error updating wiki. Please try again."
      render :edit
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
    @wiki.user = current_user
    authorize @wiki
     
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to wikis_path
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end
  end 
end
