class BuyLogsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :item_find, only:[:index, :create]
  def index
    @order_form = OrderForm.new
    if @item.user_id == current_user.id || @item.buy_log
      redirect_to root_path
    end


  end
  
  def create
    @order_form = OrderForm.new(order_form_params)
    if @order_form.valid?
      pay_item
      @order_form.save
      redirect_to root_path
    else
      render :index
    end
  end


  private
  def order_form_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :address, :build, :phone_number).merge(user_id: current_user.id,item_id: params[:item_id],token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item[:price],
      card: order_form_params[:token],
      currency: 'jpy'
    )
  end

  def item_find
    @item = Item.find(params[:item_id])
  end
end
