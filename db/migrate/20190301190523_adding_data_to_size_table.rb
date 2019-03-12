class AddingDataToSizeTable < ActiveRecord::Migration[5.2]
  def change
    Size.create(:size => "S")
    Size.create(:size => "M")
    Size.create(:size => "L")
    Size.create(:size => "XL")
    Size.create(:size => "XXL")
    Size.create(:size => "7")
    Size.create(:size => "7.5")
    Size.create(:size => "8")
    Size.create(:size => "8.5")
    Size.create(:size => "9")
    Size.create(:size => "9.5")
    Size.create(:size => "10")
    Size.create(:size => "10.5")
    Size.create(:size => "11")
    Size.create(:size => "11.5")
    Size.create(:size => "12")
    Size.create(:size => "12.5")
    Size.create(:size => "13")
    Size.create(:size => "13.5")
    Size.create(:size => "N/A")
  end
end
