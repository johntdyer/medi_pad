class ParameterController < ApplicationController
  
    before_filter :authenticate_user!

    # GET /charges
    # GET /charges.xml
    def index
      @parameters = Parameter.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @parameters }
      end
    end

    # GET /charges/1
    # GET /charges/1.xml
    def show
      @parameter = Parameter.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @parameter }
      end
    end

    # GET /charges/new
    # GET /charges/new.xml
    def new
      @parameter = Parameter.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @parameter }
      end
    end

    # GET /charges/1/edit
    def edit
      @parameter = Parameter.find(params[:id])
    end

    # POST /charges
    # POST /charges.xml
    def create

      @parameter = Parameter.new(params[:charge])
      respond_to do |format|
        if @parameter.save
          format.html { 
            #	redirect_to(@parameter, :notice => 'Charge was successfully created.') 
            redirect_to "/parameters/#{@parameter.id}"
          }
          format.xml  { render :xml => @parameter, :status => :created, :location => @parameter }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @parameter.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /charges/1
    # PUT /charges/1.xml
    def update
      @parameter = Parameter.find(params[:id])

      respond_to do |format|
        if @parameter.update_attributes(params[:charge])
          format.html { redirect_to(@parameter, :notice => 'Charge was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @parameter.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /charges/1
    # DELETE /charges/1.xml
    def destroy
      @parameter = Parameter.find(params[:id])
      @parameter.destroy

      respond_to do |format|
        format.html { redirect_to "/parameters/#{@parameter.id}"}
        format.xml  { head :ok }
      end
    end

   

    end


  