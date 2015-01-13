class CategoriesController < ApplicationController
  before_action :set_category, only: [:toggle_active, :move_up, :move_down, :edit, :update, :destroy]
  before_action :set_category_with_related_models, only: [:show, :edit, :update, :destroy]

  def toggle_active
    @category.update_attribute :active, !@category.active
    render nothing: true
  end

  def move_up
    OrderingService.new(@category).move_up
    render nothing: true
  end

  def move_down
    OrderingService.new(@category).move_down
    render nothing: true
  end

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.includes(:topic).order('topics.order', :order).all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    if params[:topic_id]
      @category = Topic.find(params[:topic_id]).categories.build
    else
      @category = Category.new
    end
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category.topic, notice: 'Category was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    if @category.update(category_params)
      redirect_to @category.topic, notice: 'Category was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    topic = @category.topic
    @category.destroy
    redirect_to topic
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  def set_category_with_related_models
    @category = Category.includes(:topic, values: :promos).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params[:category].permit(:topic_id, :name, :displayed_name, :active)
  end
end
