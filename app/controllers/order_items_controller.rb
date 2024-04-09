class OrderItemsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @products = @order.supplier.product_models
    @order_item = OrderItem.new
  end

  def create
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.new(params.require(:order_item).permit(:product_model_id, :quantity))
    @order_item.order = @order
    if @order_item.save
      redirect_to @order, notice: "Item adicionado com sucesso"
    else
      @order = Order.find(params[:order_id])
      @products = ProductModel.all.where supplier: @order.supplier
      flash.now[:notice] = 'Problemas ao adicionar item'
      render 'new'
    end
  end
end
