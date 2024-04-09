class ProductModelsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    @product_models = ProductModel.all
  end

  def new
    @product_model = ProductModel.new
    set_suppliers
  end

  def create
    @product_model = ProductModel.new(product_model_params)

    if @product_model.save
      redirect_to @product_model, notice: 'Modelo de produto cadastrado com sucesso'
    else
      set_suppliers
      flash.now[:notice] = 'Problema ao criar modelo de produto'
      render 'new'
    end
  end

  def show
    @product_model = ProductModel.find(params[:id])
  end

  private

  def set_suppliers
    @suppliers = Supplier.all
  end

  def product_model_params
    params.require(:product_model).permit(:name, :weight, :width, :heigth, :depth, :sku, :supplier_id)
  end
end
