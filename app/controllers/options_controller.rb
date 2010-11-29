class OptionsController < ApplicationController

  before_filter :authenticate_user!

  # GET /options
  # GET /options.xml
  def index
    @options = Option.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @options }
    end
  end

  # GET /options/1
  # GET /options/1.xml
  def show
    @option = Option.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @option }
      format.json  { render :json => @option }

    end
  end

  # GET /options/new
  # GET /options/new.xml
  def new
    @option = Option.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @option }
    end
  end

  # GET /options/1/edit
  def edit
    @option = Option.find(params[:id])
  end

  # POST /options
  # POST /options.xml
  def create
    @option = Option.new(params[:option])

    respond_to do |format|
      if @option.save


        format.html { redirect_to("/procedures/#{@option.procedure_id}/edit", :notice => 'Option was successfully created.') }
        format.xml  { render :xml => @option, :status => :created, :location => @option }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /options/1
  # PUT /options/1.xml
  def update
    @option = Option.find(params[:id])

    respond_to do |format|
      if @option.update_attributes(params[:option])
        format.html { redirect_to(@option, :notice => 'Option was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /options/1
  # DELETE /options/1.xml
  def destroy
    @option = Option.find(params[:id]) 
    procedure_id = @option.procedure_id

    @option.destroy

    respond_to do |format|
      format.html { redirect_to("/procedures/#{procedure_id}/edit") }
      format.xml  { head :ok }
    end
  end
end
