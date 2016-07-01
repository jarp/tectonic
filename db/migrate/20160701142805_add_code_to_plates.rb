class AddCodeToPlates < ActiveRecord::Migration[5.0]
  def change
    add_column :plates, :code, :string
  end
end
