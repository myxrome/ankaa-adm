class ExtractorsController < ApplicationController
  before_action :set_extractor, only: [:test, :show, :edit, :update, :destroy]
  before_action :set_mapping, only: [:new]

  def test
    render json: @extractor.test(params[:url])
  end

  # GET /extractors/1
  def show
  end

  # GET /extractors/new
  def new
    @extractor = @mapping.extractors.build(type: params[:type])
  end

  # GET /extractors/1/edit
  def edit
  end

  # POST /extractors
  def create
    @extractor = Extractor.new(extractor_params)

    if @extractor.save
      redirect_to @extractor.mapping, notice: 'Extractor was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /extractors/1
  def update
    if @extractor.update(extractor_params)
      redirect_to @extractor.mapping, notice: 'Extractor was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /extractors/1
  def destroy
    mapping = @extractor.mapping
    @extractor.destroy
    redirect_to mapping, notice: 'Extractor was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_extractor
    @extractor = Extractor.find(params[:id])
  end

  def set_mapping
    @mapping = Mapping.find(params[:mapping_id])
  end

  # Only allow a trusted parameter "white list" through.
  def extractor_params
    result = params[:text] || params[:attribute_value] || params[:attachment] || params[:has_many]
    result.permit(:mapping_id, :type, :name, :key, :element, :attr, :substring, :prefix, :postfix,
                  :order, :source)
  end
end
