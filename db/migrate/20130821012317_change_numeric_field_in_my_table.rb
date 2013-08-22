class ChangeNumericFieldInMyTable < ActiveRecord::Migration
  def up
    change_column :images, :aspect_ratio, :decimal, :precision => 8, :scale => 6
  end

  def down
  end
end
