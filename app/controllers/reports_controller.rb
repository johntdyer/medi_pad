class ReportsController < ApplicationController
  
  before_filter :require_doctor
  
  
  def index
    @search=Charge.search(params[:search] || {:recorded=>false})
    @reports=@search.all
     respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @reports }
      end
  end
  
  def show_only_recorded
    logger.info { "" }
    logger.info { "@@@ Log: #{params.inspect}" }
    redirect_to "/reports/"
    
  end
end
