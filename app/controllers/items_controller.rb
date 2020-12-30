class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :find, only: [:show, :edit, :update]
    def index
      @items = Item.includes(:user).order("created_at DESC")
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

    end

    def edit
      if @item.user_id != current_user.id
        redirect_to action: :index
      end
    end

    def update
      if @item.user_id != current_user.id
        redirect_to action: :index
      end
      
      if @item.update(item_params)
        redirect_to item_path
      else
        render :edit
      end
    end

    def destroy
      item = Item.find(params[:id])
      item.destroy
      redirect_to root_path
    end
  
    private
    def item_params
      params.require(:item).permit(:name, :message, :category_id, :status_id, :charge_id, :schedule_id, :prefecture_id, :price, :image).merge(user_id: current_user.id)
    end

    def find
      @item = Item.find(params[:id])
    end
  
  end
  