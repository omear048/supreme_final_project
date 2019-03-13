class ChangeAddidasToAdidas < ActiveRecord::Migration[5.2]
  def change
    execute "Update desginers SET designer = 'Adidas' WHERE designer = 'Addidas'"
  end
end
