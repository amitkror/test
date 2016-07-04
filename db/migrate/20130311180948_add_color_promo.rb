class AddColorPromo < ActiveRecord::Migration
  def up
    Promo.where(
      title: "Colored Background",
      is_locked: false,
      is_image:true,
      control: "colored_background"
    ).first_or_create

    add_column :promo_instances, :color, :string, default: ""
  end

  def down
    remove_column :promo_instances, :color
  end
end
