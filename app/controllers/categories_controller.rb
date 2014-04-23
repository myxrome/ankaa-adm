class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params[:category].permit(:topic_id, :name, :displayed_name)
  end
end
