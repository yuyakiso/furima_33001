class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new
    def index
      @items = Item.includes(:user)
    end
  
    def new
      @item = Item.new
    end
  
    def create
      @item = Item.new(item_params)
      if @item.save
        redirect_to root_path
      else
        render :new
      end
    end
  
    def show
      @item = Item.find(params[:id])
    end
  
    private
    def item_params
      params.require(:item).permit(:name, :message, :category_id, :status_id, :charge_id, :schedule_id, :prefecture_id, :price, :image).merge(user_id: current_user.id)
    end
  
  end
  