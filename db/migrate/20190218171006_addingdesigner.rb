class Addingdesigner < ActiveRecord::Migration[5.2]
  def change
    Designer.create(designer: "Other");
  end
end
