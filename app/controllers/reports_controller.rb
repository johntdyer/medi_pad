class ReportsController < ApplicationController
  
  def index
    #@patients = Patient.all(:order=>'facility')
    #@patients_charges = Patient.all(:order=>'facility')
    #@patients = Patient.facility_like_all(params[:search].to_s.split).ascend_by_room


    @search=Charge.search(params[:search] || {:recorded=>false})
    @charges=@search.all
    respond_to do |format|

      format.html # index.html.erb
      format.xml  { render :xml => @charges }
    end
  end
  
end
