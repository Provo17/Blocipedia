class WikisController < ApplicationController
  
	skip_before_filter :authenticate_user!, only: [:index, :show]
	before_action :set_wiki, only: [:show, :edit, :update, :destroy]
  
  def index
    @wikis= policy_scope(Wiki)
  end

  def new
    @wiki = Wiki.new
  end
  
  def create
    @wiki = current_user.wikis.new(wiki_params)
    authorize @wiki
    
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
    authorize @wiki
  end


  def edit
    @wiki = Wiki.find(params[:id])
    @wiki.user = current_user
    authorize @wiki
  end
  
  def update
    @wiki.assign_attributes(wiki_params)
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
  
  private

  def wiki_params
    if current_user.standard?
      params.require(:wiki).permit(:title, :body)
    else
      params.require(:wiki).permit(:title, :body, :private)
    end
  end

  def set_wiki
  	@wiki = Wiki.find(params[:id])
  end  
end
