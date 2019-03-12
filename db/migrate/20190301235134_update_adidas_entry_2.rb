class UpdateAdidasEntry2 < ActiveRecord::Migration[5.2]
  def change
    execute('UPDATE designers SET designer = "Adidas" where designer = "Addidas"')
  end
end
