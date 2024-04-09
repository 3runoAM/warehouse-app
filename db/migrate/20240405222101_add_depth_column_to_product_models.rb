class AddDepthColumnToProductModels < ActiveRecord::Migration[7.1]
  def change
    add_column :product_models, :depth, :integer
  end
end
