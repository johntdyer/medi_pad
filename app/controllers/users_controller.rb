class UsersController < ApplicationController
  helper :all

  require 'rbyaml'

  def edit_procedure  
    @doctor = current_user
    favorites = RbYAML.load(@doctor.favorites)
    
    if params[:commit]=='delete'
        logger.info("@@@@ #{params[:commit]} #{params[:procedure_code]} => #{current_user.username}")

        favorites.delete(params[:procedure_code])        
        @doctor.update_attributes(:favorites=>favorites.to_yaml)
        
      elsif params[:commit]=='add'
        logger.info("@@@@ #{params[:commit]} #{params[:procedure_code]} => #{current_user.username}")
        favorites<<params[:procedure_code]
        @doctor.update_attributes(:favorites=>favorites.to_yaml)

      else
        logger.info "@@@ LOG: Error: edit_procedure, unexpected action param"
        redirect_to "/users/edit"
      end
      redirect_to "/users/edit"
  end   
  
 
end