class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :edit, :update, :destroy]

  def show
    @stock = @warehouse.stock_products.where.missing(:stock_product_destination).group(:product_model).count
    @product_models = ProductModel.all
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save
      redirect_to root_path, notice: "Galpão cadastrado com sucesso"
    else
      flash.now[:notice] = "Problema ao cadastrar galpão"
      render 'new'
    end
  end

  def edit; end

  def update
    if @warehouse.update(warehouse_params)
      redirect_to warehouse_path(@warehouse.id), notice: "Galpão atualizado com sucesso"
    else
      flash.now[:notice] = 'Problema ao atualizar o galpão'
      render :edit
    end
  end

  def destroy
    @warehouse.destroy
    redirect_to root_path, notice: 'Galpão removido com sucesso'
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:id, :name, :code, :city, :area, :address, :CEP, :description)
  end
end