class ChangeAddidasToAdidas < ActiveRecord::Migration[5.2]
  def change
    Designer.where(:name => 'Addidas').update(designer: 'Adidas')
  end
end
