class ScrapersController < ApplicationController
  before_action :set_scraper, only: [:toggle_active, :test, :show, :edit, :update, :destroy]

  def toggle_active
    @scraper.update_attribute :active, !@scraper.active
    render nothing: true
  end

  def test
    service = TestingScraperService.new(@scraper)
    render json: service.perform(params[:url])
  end

  # GET /scrapers
  def index
    @scrapers = Scraper.order(:name).all
  end

  # GET /scrapers/1
  def show
  end

  # GET /scrapers/new
  def new
    @scraper = Scraper.new
  end

  # GET /scrapers/1/edit
  def edit
  end

  # POST /scrapers
  def create
    @scraper = Scraper.new(scraper_params)

    if @scraper.save
      redirect_to @scraper, notice: 'Scraper was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /scrapers/1
  def update
    if @scraper.update(scraper_params)
      redirect_to @scraper, notice: 'Scraper was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /scrapers/1
  def destroy
    @scraper.destroy
    redirect_to scrapers_url, notice: 'Scraper was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_scraper
    @scraper = Scraper.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def scraper_params
    params[:scraper].permit(:name, :scope, :selector, :condition, :element, :attr, :source_pattern, :source_replacement,
                            :source_postfix, :source, :url_prefix, :url_postfix, :active)
  end
end
