class VirtualContextsController < ApplicationController
  before_action :set_virtual_context, only: [:show, :edit, :update, :destroy]

  # GET /virtual_contexts
  def index
    @virtual_contexts = VirtualContext.includes(:virtual_context_type).order(:name).all
  end

  # GET /virtual_contexts/1
  def show
  end

  # GET /virtual_contexts/new
  def new
    @virtual_context = VirtualContextType.find(params[:virtual_context_type_id]).
        virtual_contexts.new
  end

  # GET /virtual_contexts/1/edit
  def edit
  end

  # POST /virtual_contexts
  def create
    @virtual_context = VirtualContext.new(virtual_context_params)

    if @virtual_context.save
      redirect_to @virtual_context, notice: 'Virtual context was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /virtual_contexts/1
  def update
    if @virtual_context.update(virtual_context_params)
      redirect_to @virtual_context, notice: 'Virtual context was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /virtual_contexts/1
  def destroy
    @virtual_context.destroy
    redirect_to virtual_contexts_url, notice: 'Virtual context was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_virtual_context
    @virtual_context = VirtualContext.includes(:virtual_context_type).find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def virtual_context_params
    params[:virtual_context].permit(:name, :description, :virtual_context_type_id)
  end
end
