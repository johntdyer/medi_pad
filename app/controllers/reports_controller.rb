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
  
  def search
    if params.has_key?(:time)
      date = params[:time]
      logger.debug { "#{date_convert(params[:time]).inspect}" }
     # @search = Charge.search(params[:search])
    else params.has_key?(:name)
      @search = Charge.search(:patient_name_contains=>params[:name])
    end
    @reports=@search.all


    render :action => "index"
   end


   def date_convert(v)
    case v.downcase
      when 'hour'
        @search=Charge.where('updated_at > ?', Time.zone.now - 60.minutes)
        
     #   return 60
      when 'day'
        return 1440
      when 'week'
        return 10080
      when 'month'
        @search=Charge.where('updated_at > ?', Time.now - 44640.minutes)
        
      #  return 44640
        
      when 'year'
        @search=Charge.where('updated_at > ?', Time.now - 525600.minutes)
        
       # return 525600
      else 
        @search = Charge.search(params[:search])
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
