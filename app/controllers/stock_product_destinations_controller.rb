class StockProductDestinationsController < ApplicationController
  def create
    product = ProductModel.find(params[:product_model_id])
    warehouse = Warehouse.find(params[:warehouse_id])
    stock = StockProduct.find_by(warehouse: warehouse, product_model: product)

    if stock != nil
      stock.create_stock_product_destination!(recipient: params[:recipient], address: params[:address])
      redirect_to warehouse, notice: 'Item retirado com sucesso'
    end
  end
end