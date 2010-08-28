class ImportController < ApplicationController
  
  def index
      @imports = Import.all(:limit => 10)
    end

    def show
      @import = Import.find(params[:id])
    end

    def new
      @import = Import.new
    end

    def create
      @import = Import.new(params[:import])
      if @import.save
        flash[:notice] = "Successfully created import."
        redirect_to @import
      else
        render :action => 'new'
      end
    end

    def edit
      @import = Import.find(params[:id])
    end

    def update
      @import = Import.find(params[:id])
      if @import.update_attributes(params[:import])
        flash[:notice] = "Successfully updated import."
        redirect_to @import
      else
        render :action => 'edit'
      end
    end

    def destroy
      @import = Import.find(params[:id])
      @import.destroy
      flash[:notice] = "Successfully destroyed import."
      redirect_to imports_url
    end
  end