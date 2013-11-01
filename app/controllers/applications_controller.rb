class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy]

  # GET /applications
  # GET /applications.json
  def index
    @applications = Application.all
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
  end

  # GET /applications/new
  def new
    @application = Application.new
    session[:key] = @application.key
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = Application.new(application_create_params)
    session[:key] = nil

    if @application.save
      redirect_to @application, notice: 'Application was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /applications/1
  # PATCH/PUT /applications/1.json
  def update
    if @application.update(application_update_params)
      redirect_to @application, notice: 'Application was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    @application.destroy
    redirect_to applications_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_application
    @application = Application.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def application_update_params
    params[:application].permit(:name, category_ids: [])
  end

  def application_create_params
    params[:application].merge(key: session[:key]).permit(:name, :key, category_ids: [])
  end

end
