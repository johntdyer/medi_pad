class ReportsController < ApplicationController
  
  before_filter :require_doctor
  
  
  def index

    @search = Charge.search(params[:search])
    #@search=Charge.where('updated_at < ?', Time.now - 60.minutes).search(params[:search])
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
      #@search=Charge.where('updated_at < ?', Time.zone.now - 15.minute).search(params[:search])
      if date_convert(params[:time])
        @search=Charge.where('updated_at >= ?', Time.now - date_convert(params[:time])).search(params[:search])
      else
        logger.debug { "@@@@" }
        
      @search=Charge.search(params[:search])
      flash[:notice] = "#{params[:time]} is not a valid search term"
    end
    else params.has_key?(:name)
      @search = Charge.search(:patient_name_contains=>params[:name])
    end
    @reports=@search.all
    
    render :action => "index"
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
        #redirect_to '/reports'
  end
  
  
  
  private
  
  
   def date_convert(v)
    case v.downcase
      when 'hour'
        return 60.minutes.to_i
      when 'day'
        return 24.hours.to_i
      when 'week'
        return 168.hours.to_i
      when 'month'
        return 31.days.to_i
      when 'year'
        return 365.days.to_i
      else 
        return false
      end
  end




end
