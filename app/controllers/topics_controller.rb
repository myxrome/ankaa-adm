class TopicsController < ApplicationController
  before_action :set_topic, only: [:toggle_active, :move_up, :move_down, :edit, :update, :destroy]
  before_action :set_topic_with_related_models, only: :show

  def toggle_active
    @topic.update_attribute :active, !@topic.active
    render nothing: true
  end

  def move_up
    @topic.move_up
    render nothing: true
  end

  def move_down
    @topic.move_down
    render nothing: true
  end

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.includes(:categories).order(:order).all
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
  end

  # GET /topics/new
  def new
    @topic = Topic.new
    session[:key] = @topic.key
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_create_params)
    session[:key] = nil

    if @topic.save
      redirect_to topics_url, notice: 'Topic was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    if @topic.update(topic_update_params)
      redirect_to topics_url, notice: 'Topic was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    redirect_to topics_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_topic
    @topic = Topic.find(params[:id])
  end

  def set_topic_with_related_models
    @topic = Topic.includes(:categories).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def topic_update_params
    params[:topic].permit(:name, :active)
  end

  def topic_create_params
    params[:topic].merge(key: session[:key]).permit(:name, :key, :active)
  end

end
