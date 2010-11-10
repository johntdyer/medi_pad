class AnatomiesController < ApplicationController
  # GET /anatomies
  # GET /anatomies.xml
  def index
    @anatomies = Anatomy.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @anatomies }
    end
  end

  # GET /anatomies/1
  # GET /anatomies/1.xml
  def show
    @anatomy = Anatomy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @anatomy }
    end
  end

  # GET /anatomies/new
  # GET /anatomies/new.xml
  def new
    @anatomy = Anatomy.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @anatomy }
    end
  end

  # GET /anatomies/1/edit
  def edit
    @anatomy = Anatomy.find(params[:id])
  end

  # POST /anatomies
  # POST /anatomies.xml
  def create
    @anatomy = Anatomy.new(params[:anatomy])

    respond_to do |format|
      if @anatomy.save
        format.html { redirect_to(@anatomy, :notice => 'Anatomy was successfully created.') }
        format.xml  { render :xml => @anatomy, :status => :created, :location => @anatomy }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @anatomy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /anatomies/1
  # PUT /anatomies/1.xml
  def update
    @anatomy = Anatomy.find(params[:id])

    respond_to do |format|
      if @anatomy.update_attributes(params[:anatomy])
        format.html { redirect_to(@anatomy, :notice => 'Anatomy was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @anatomy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /anatomies/1
  # DELETE /anatomies/1.xml
  def destroy
    @anatomy = Anatomy.find(params[:id])
    @anatomy.destroy

    respond_to do |format|
      format.html { redirect_to(anatomies_url) }
      format.xml  { head :ok }
    end
  end
end
