class TopicGroupsController < ApplicationController
  before_action :set_topic_group, only: [:toggle_active, :move_up, :move_down, :edit, :update, :destroy]
  before_action :set_topic_group_with_related_models, only: :show

  def toggle_active
    @topic_group.update_attribute :active, !@topic_group.active
    render nothing: true
  end

  def move_up
    OrderingService.new(@topic_group).move_up
    render nothing: true
  end

  def move_down
    OrderingService.new(@topic_group).move_down
    render nothing: true
  end

  # GET /topic_groups
  def index
    @topic_groups = TopicGroup.includes(:topics).order(:order).all
  end

  # GET /topic_groups/1
  def show
  end

  # GET /topic_groups/new
  def new
    @topic_group = TopicGroup.new
    session[:key] = @topic_group.key
  end

  # GET /topic_groups/1/edit
  def edit
  end

  # POST /topic_groups
  def create
    @topic_group = TopicGroup.new(topic_group_create_params)
    session[:key] = nil

    if @topic_group.save
      redirect_to topic_groups_url, notice: 'Topic Group was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /topic_groups/1
  def update
    if @topic_group.update(topic_group_update_params)
      redirect_to topic_groups_url, notice: 'Topic Group was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /topic_groups/1
  def destroy
    if @topic_group.destroy
      redirect_to topic_groups_url, notice: 'Topic Group was successfully destroyed.'
    else
      redirect_to topic_groups_url, alert: @topic_group.errors[:base].join(' ')
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic_group
      @topic_group = TopicGroup.find(params[:id])
    end

    def set_topic_group_with_related_models
      @topic_group = TopicGroup.includes(:topics).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def topic_group_update_params
      params[:topic_group].permit(:name, :active)
    end

    def topic_group_create_params
      params[:topic_group].merge(key: session[:key]).permit(:name, :key, :active)
    end

end
