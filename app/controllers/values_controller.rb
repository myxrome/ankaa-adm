class ValuesController < ApplicationController
  before_action :set_value, only: [:show, :edit, :update, :destroy]

  def autocomplete_description_caption
    templates = DescriptionTemplate.select_captions_like params[:name]
    result = templates.collect do |t|
      {value: t.caption}
    end
    render json: result
  end

  # GET /values
  # GET /values.json
  def index
    @values = Value.all
  end

  # GET /values/1
  # GET /values/1.json
  def show
  end

  # GET /values/new
  def new
    @value = Value.new
  end

  # GET /values/1/edit
  def edit
  end

  # POST /values
  # POST /values.json
  def create
    @value = Value.new(value_params)

    if @value.save
      redirect_to @value, notice: 'Value was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /values/1
  # PATCH/PUT /values/1.json
  def update
    if @value.update(value_params)
      redirect_to @value, notice: 'Value was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /values/1
  # DELETE /values/1.json
  def destroy
    @value.destroy
    redirect_to values_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_value
    @value = Value.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def value_params
    params[:value].permit(:name, :old_price, :new_price, :discount, :end_date, :url, :category_id, :active,
                          descriptions_attributes: [:id, :caption, :order, :text, :red, :bold,
                                                    :_destroy],
                          promos_attributes: [:id, :image, :order, :_destroy])
  end
end
