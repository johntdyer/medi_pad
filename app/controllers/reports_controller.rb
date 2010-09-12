class ReportsController < ApplicationController
  
  before_filter :require_doctor
  
  
  def index

    @search = Charge.search(params[:search])
    @reports=@search.all
    if request.xml_http_request?
      render :partial => "reports", :layout => false
    end
    
     respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @reports }
      end
  end
  
  def show_only_recorded
    logger.info { "" }
    logger.info { "@@@ Log: #{params.inspect}" }

      show_only_recorded = params[:show_only_recorded]

        if show_only_recorded=='true'
            @search=Charge.search(params[:search])
            #.where({:recorded=>false})
        elsif show_only_recorded == 'false'
            logger.info { "FALSE" }
            @search=Charge.search(params[:search])
            #.where({:recorded=>false})
        else
          logger.info { "show_only_recorded not boolean" }
        end
        
        @reports=@search.all
    
#        redirect_to '/reports'

    
  end
end
