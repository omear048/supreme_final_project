class ChangeAddidasToAdidas < ActiveRecord::Migration[5.2]
  def change
    execute "Update designers SET designer = 'Adidas' WHERE designer = 'Addidas'"
  end
end
