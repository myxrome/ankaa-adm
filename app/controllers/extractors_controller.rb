class ExtractorsController < ApplicationController
  before_action :set_extractor, only: [:test, :show, :edit, :update, :destroy]
  before_action :set_partition, only: [:new]

  def test
    service = TestingExtractorServiceFactory.instance.build_test_extractor_service(@extractor)
    render json: service.test(params[:url])
  end

  # GET /extractors/1
  def show
  end

  # GET /extractors/new
  def new
    @extractor = @partition.extractors.build(type: params[:type])
  end

  # GET /extractors/1/edit
  def edit
  end

  # POST /extractors
  def create
    @extractor = Extractor.new(extractor_params)

    if @extractor.save
      redirect_to @extractor.partition, notice: 'Extractor was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /extractors/1
  def update
    if @extractor.update(extractor_params)
      redirect_to @extractor.partition, notice: 'Extractor was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /extractors/1
  def destroy
    partition = @extractor.partition
    @extractor.destroy
    redirect_to partition, notice: 'Extractor was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_extractor
    @extractor = Extractor.find(params[:id])
  end

  def set_partition
    @partition = Partition.find(params[:partition_id])
  end

  # Only allow a trusted parameter "white list" through.
  def extractor_params
    result = params[:text] || params[:attribute_value] || params[:attachment] || params[:has_many]
    result.permit(:partition_id, :type, :name, :key, :element, :attr, :substring, :prefix, :postfix,
                  :order, :source)
  end
end
