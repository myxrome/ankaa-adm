class MappingsController < ApplicationController
  before_action :set_mapping, only: [:show, :edit, :update, :destroy]
  before_action :set_source, only: [:new]

  # GET /mappings/1
  def show
  end

  # GET /mappings/new
  def new
    @mapping = @source.mappings.build
  end

  # GET /mappings/1/edit
  def edit
  end

  # POST /mappings
  def create
    @mapping = Mapping.new(mapping_params)

    if @mapping.save
      redirect_to @mapping, notice: 'Mapping was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /mappings/1
  def update
    if @mapping.update(mapping_params)
      redirect_to @mapping, notice: 'Mapping was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /mappings/1
  def destroy
    source = @mapping.source
    @mapping.destroy
    redirect_to source, notice: 'Mapping was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_mapping
    @mapping = Mapping.find(params[:id])
  end

  def set_source
    @source = (Scraper.find(params[:scraper_id]) if params[:scraper_id]) ||
        (Transformer.find(params[:transformer_id]) if params[:transformer_id])
  end

  # Only allow a trusted parameter "white list" through.
  def mapping_params
    params[:mapping].permit(:source_id, :source_type, :scope)
  end
end
