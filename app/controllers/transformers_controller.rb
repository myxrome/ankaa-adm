class TransformersController < ApplicationController
  before_action :set_transformer, only: [:show, :edit, :update, :destroy]
  before_action :set_mapping, only: [:new]

  # GET /transformers/1
  def show
  end

  # GET /transformers/new
  def new
    @transformer = @mapping.transformers.build(type: params[:type])
  end

  # GET /transformers/1/edit
  def edit
  end

  # POST /transformers
  def create
    @transformer = Transformer.new(transformer_params)

    if @transformer.save
      redirect_to @transformer.mapping, notice: 'Transformer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /transformers/1
  def update
    if @transformer.update(transformer_params)
      redirect_to @transformer.mapping, notice: 'Transformer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /transformers/1
  def destroy
    mapping = @transformer.mapping
    @transformer.destroy
    redirect_to mapping, notice: 'Transformer was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_transformer
    @transformer = Transformer.find(params[:id])
  end

  def set_mapping
    @mapping = Mapping.find(params[:mapping_id])
  end

  # Only allow a trusted parameter "white list" through.
  def transformer_params
    result = params[:text] || params[:attachment] || params[:order] || params[:has_many]
    result.permit(:mapping_id, :type, :key, :selector, :prefix, :postfix)
  end
end
