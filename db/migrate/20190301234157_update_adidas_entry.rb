class UpdateAdidasEntry < ActiveRecord::Migration[5.2]
  def change
    execute('UPDATE categories SET category = "Adidas" where category = "Addidas"')
  end
end
