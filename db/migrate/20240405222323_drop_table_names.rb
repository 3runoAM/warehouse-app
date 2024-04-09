class DropTableNames < ActiveRecord::Migration[7.1]
  def change
    drop_table :names
  end
end
