class ProceduresController < ApplicationController

  before_filter :authenticate_user!, :except => [:show ] #, :edit, :update] 
	
  # GET /procedures
  # GET /procedures.xml
  def index
    @procedures = Procedure.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @procedures }
    end
  end

  # GET /procedures/1
  # GET /procedures/1.xml
  def show
    @procedure = Procedure.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @procedure }
      format.json  { render :json => @procedure }
      
    end
  end

  # GET /procedures/new
  # GET /procedures/new.xml
  def new
    @procedure = Procedure.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @procedure }
    end
  end

  # GET /procedures/1/edit
  def edit
    @procedure = Procedure.find(params[:id]) 
    @options = Option.new
    @types = Type.new
    
  end

  # POST /procedures
  # POST /procedures.xml
  def create
    @procedure = Procedure.new(params[:procedure])

    respond_to do |format|
      if @procedure.save
        format.html { redirect_to("/procedures", :notice => 'Procedure was successfully created.') }
        format.xml  { render :xml => @procedure, :status => :created, :location => @procedure }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @procedure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /procedures/1
  # PUT /procedures/1.xml
  def update
    @procedure = Procedure.find(params[:id])
    @options = Option.new
    @types = Type.new
    respond_to do |format|
      if @procedure.update_attributes(params[:procedure])
        format.html { redirect_to "/procedures" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @procedure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /procedures/1
  # DELETE /procedures/1.xml
  def destroy
    @procedure = Procedure.find(params[:id])
    @procedure.destroy

    respond_to do |format|
      format.html { redirect_to "/procedures" }
      format.xml  { head :ok }
    end

  end

  def self.find_incomplete
    find_all_by_complete(false, :order => 'created_at DESC')
  end

  def find_procedure_name(code)
    @procedure=Procedure.find_by_procedure_code(code)
  end

end
