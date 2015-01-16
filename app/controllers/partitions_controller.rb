class PartitionsController < ApplicationController
  before_action :set_partition, only: [:move_up, :move_down, :show, :edit, :update, :destroy]
  before_action :set_source, only: [:new]

  def move_up
    OrderingService.new(@partition).move_up
    render nothing: true
  end

  def move_down
    OrderingService.new(@partition).move_down
    render nothing: true
  end

  # GET /partitions/1
  def show
  end

  # GET /partitions/new
  def new
    @partition = @source.partitions.build
  end

  # GET /partitions/1/edit
  def edit
  end

  # POST /partitions
  def create
    @partition = Partition.new(partition_params)

    if @partition.save
      redirect_to @partition, notice: 'Partition was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /partitions/1
  def update
    if @partition.update(partition_params)
      redirect_to @partition, notice: 'Partition was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /partitions/1
  def destroy
    source = @partition.source
    @partition.destroy
    redirect_to source, notice: 'Partition was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_partition
    @partition = Partition.find(params[:id])
  end

  def set_source
    @source = (Scraper.find(params[:scraper_id]) if params[:scraper_id]) ||
        (Extractor.find(params[:extractor_id]) if params[:extractor_id])
  end

  # Only allow a trusted parameter "white list" through.
  def partition_params
    params[:partition].permit(:source_id, :source_type, :name, :scope)
  end
end
