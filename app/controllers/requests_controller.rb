class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request, except: [:new, :create, :index, :list]
  before_action :is_authorised, only: [:edit, :update, :destroy]
  before_action :set_categories, only: [:new, :edit, :list]

  def index
    @requests = current_user.requests
  end

  def new
    @request = current_user.requests.build
  end

  def create
    @request = current_user.requests.build(request_params)
    if @request.save
      redirect_to requests_path, notice: "Gardado..."
    else
      redirect_to request.referrer, flash: {error: @request.errors.full_messages.join(', ')}
    end
  end

  def edit
  end

  def update
    if @request.update(request_params)
      redirect_to requests_path, notice: "gardado..."
    else
      redirect_to request.referrer, flash: {error: @request.errors.full_messages.join(', ')}
    end
  end

  def show
  end

  def destroy
    @request.destroy
    redirect_to requests_path, notice: "Removido..."
  end

  def list
    @category_id = params[:category]

    if @category_id.present?
      @requests = Request.where(category_id: @category_id)
    else
      @requests = Request.all
    end
  end

  def offers
    @offers = @request.offers
  end

  def my_offers
    @offers = current_user.offers
  end

  private

  def set_categories
    @categories = Category.all
  end

  def set_request
    @request = Request.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Registro nao encontrado"
    redirect_to :action => 'index'
  end

  def is_authorised
    redirect_to root_path, alert: "Não tem permissão" unless current_user.id == @request.user_id
  end

  def request_params
    params.require(:request).permit(:description, :category_id, :delivery, :budget, :attachment_file, :title)
  end
end
