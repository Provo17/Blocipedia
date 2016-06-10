class CollaboratorsController < ApplicationController
  def delete
        @wiki = Wiki.find(params[:wiki_id])
        collaborator = @wiki.collaborators.find(params[:id])

        if @wiki.collaborators.delete(collaborator)
            flash[:notice] = "Going, going, gone!!!! Collaborator deleted."
        else
            flash[:alert] = "They're still here, action failed."
        end
        redirect_to wikis_path
  end
end

# used the collaborator controller strictly for deleting a collaborator instead of adding it in the wikis controller