class MinersController < ApplicationController
  before_action :set_miner, only: [:show, :edit, :update, :destroy]

  # GET /miners
  def index
    @miners = Miner.order(:name).all
  end

  # GET /miners/1
  def show
  end

  # GET /miners/new
  def new
    @miner = Miner.new
  end

  # GET /miners/1/edit
  def edit
  end

  # POST /miners
  def create
    @miner = Miner.new(miner_params)

    if @miner.save
      redirect_to @miner, notice: 'Miner was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /miners/1
  def update
    if @miner.update(miner_params)
      redirect_to @miner, notice: 'Miner was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /miners/1
  def destroy
    @miner.destroy
    redirect_to miners_url, notice: 'Miner was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_miner
    @miner = Miner.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def miner_params
    params[:miner].permit(:name, :category_id)
  end
end
