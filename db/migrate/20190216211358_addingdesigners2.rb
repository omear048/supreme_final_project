class Addingdesigners2 < ActiveRecord::Migration[5.2]
  def change
    Designer.create(designer: "Nike");
    Designer.create(designer: "Champion");
    Designer.create(designer: "Adidas");
    Designer.create(designer: "Supreme");
    Designer.create(designer: "Stussy");
    Designer.create(designer: "Undefeated");
    Designer.create(designer: "A Bathing Ape");
    Designer.create(designer: "Billionaire Boys Club");
    Designer.create(designer: "Off-White");
    Designer.create(designer: "Louis Vuitton");
    Designer.create(designer: "Gucci");
    Designer.create(designer: "Chanel");
    Designer.create(designer: "Hermes");
    Designer.create(designer: "Versache");
    Designer.create(designer: "Saint Lauren");
    Designer.create(designer: "Burberry");
    Designer.create(designer: "MCM");
    Designer.create(designer: "Phillip Plien");
  end
end
