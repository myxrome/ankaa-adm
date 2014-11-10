class MinerScrapersController < ApplicationController
  before_action :set_miner_scraper, only: [:edit, :update, :destroy]
  before_action :set_miner, only: [:new, :create, :destroy]

  # GET /miner_scrapers/new
  def new
    @miner_scraper = @miner.miner_scrapers.build
  end

  # GET /miner_scrapers/1/edit
  def edit
  end

  # POST /miner_scrapers
  def create
    @miner_scraper = @miner.miner_scrapers.build(miner_scraper_params)

    if @miner_scraper.save
      redirect_to @miner_scraper.miner, notice: 'Miner scraper relation was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /miner_scrapers/1
  def update
    if @miner_scraper.update(miner_scraper_params)
      redirect_to @miner_scraper.miner, notice: 'Miner scraper relation was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /miner_scrapers/1
  def destroy
    @miner_scraper.destroy
    redirect_to @miner, notice: 'Miner scraper relation was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_miner_scraper
    @miner_scraper = MinerScraper.find(params[:id])
  end

  def set_miner
    @miner = Miner.find(params[:miner_id])
  end

  # Only allow a trusted parameter "white list" through.
  def miner_scraper_params
    params[:miner_scraper].permit(:scraper_id, :url_prefix, :url_postfix, :limit)
  end
end
