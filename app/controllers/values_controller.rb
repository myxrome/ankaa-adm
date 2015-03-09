class ValuesController < ApplicationController
  before_action :set_value, only: [:toggle_active]
  before_action :set_value_with_related_models, only: [:show, :edit, :update]

  def toggle_active
    @value.update_attribute :active, !@value.active
    render nothing: true
  end

  # GET /values
  # GET /values.json
  def index
    @values = Value.includes(:promos, category: :topic).
        order('topics.order', 'categories.order', :name).
        all
  end

  # GET /values/1
  # GET /values/1.json
  def show
  end

  # GET /values/1/edit
  def edit
  end

  # PATCH/PUT /values/1
  # PATCH/PUT /values/1.json
  def update
    if @value.update(value_params)
      redirect_to @value.category, notice: 'Value was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_value
    @value = Value.find(params[:id])
  end

  def set_value_with_related_models
    @value = Value.includes(:category, :promos, :descriptions).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def value_params
    params[:value].permit(:name, :old_price, :new_price, :discount, :url, :category_id, :active,
                          descriptions_attributes: [:id, :caption, :order, :text, :_destroy],
                          promos_attributes: [:id, :image, :order, :_destroy])
  end
end
