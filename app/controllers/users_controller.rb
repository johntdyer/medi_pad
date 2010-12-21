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

  # PUT /types/1
  # PUT /types/1.xml
  def update
    @user = User.find(params[:id])
      respond_to do |format|
        if @user.update_attribute(params[:user][:access_type],!params[:user][:current_value].to_b)
          format.json {render :json =>{"success"=>"true"}.to_json }
          format.xml  { head :ok }
      else 

          format.json {render :json =>{"success"=>"false"}.to_json }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
end

class String
  def to_b
    return true if self == true || self =~ /^true$/i
    return false if self == false || self.nil? || self =~ /^false$/i
    raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end
end