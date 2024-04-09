class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_and_verify_user, only: [:show, :edit, :update, :delivered, :canceled]
  def index
    @orders = current_user.orders
  end
  def show
  end

  def new
    @order = Order.new
    set_warehouses_and_suppliers
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save
      redirect_to @order, notice: 'Pedido cadastrado com sucesso'
    else
      set_warehouses_and_suppliers
      flash.now[:notice] = 'Problema ao cadastrar pedido'
      render 'new'
    end
  end

  def search
    @code = params[:query]
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  def edit
    set_warehouses_and_suppliers
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Pedido atualizado com sucesso'
    else
      set_warehouses_and_suppliers
      flash.now[:notice] = 'Problema ao atualizar pedido'
      render 'new'
    end
  end

  def delivered
    @order.delivered!
    @order.order_items.each do |item| #Percorre os items do pedido
      item.quantity.times do # Itera a quantidade de vezes de cada item no pedido
        StockProduct.create!(order: @order, product_model: item.product_model,
                             warehouse: @order.warehouse)
      end
    end
    redirect_to @order, notice: 'Situação do pedido: Entregue'
  end

  def canceled
    @order.canceled!
    redirect_to @order, notice: 'Situação do pedido: Cancelado'
  end

  private

  def set_warehouses_and_suppliers
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end

  def set_order_and_verify_user
    @order = Order.find(params[:id])
    if @order.user != current_user
      redirect_to root_path, alert: 'Você não possui acesso a este pedido.'
    end
  end
end
