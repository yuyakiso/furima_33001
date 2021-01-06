class BuyLogsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  def index
    @order_form = OrderForm.new
    @item = Item.find(params[:item_id])
    if @item.user_id == current_user.id
      redirect_to root_path
    elsif @item.buy_log
      redirect_to root_path
    end


  end
  
  def create
    @item = Item.find(params[:item_id])
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
end
