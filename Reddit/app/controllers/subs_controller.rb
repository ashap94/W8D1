class SubsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :be_moderator, only: [:edit, :update, :destroy]

  def index
    @subs = Sub.all.sort_by { |sub| sub.title }
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end

  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private 

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
