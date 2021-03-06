class PartnersController < ApplicationController
  before_action :set_partner, only: [:toggle_active, :show, :edit, :update, :destroy]

  def toggle_active
    @partner.update_attribute :active, !@partner.active
    render nothing: true
  end

  # GET /partners
  def index
    @partners = Partner.order(:name).all
  end

  # GET /partners/1
  def show
  end

  # GET /partners/new
  def new
    @partner = Partner.new
  end

  # GET /partners/1/edit
  def edit
  end

  # POST /partners
  def create
    @partner = Partner.new(partner_params)

    if @partner.save
      redirect_to @partner, notice: 'Partner was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /partners/1
  def update
    if @partner.update(partner_params)
      redirect_to @partner, notice: 'Partner was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /partners/1
  def destroy
    @partner.destroy
    redirect_to partners_url, notice: 'Partner was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_partner
    @partner = Partner.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def partner_params
    params[:partner].permit(:name, :url, :logo, :active)
  end
end
