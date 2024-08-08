class RemoveCommentsFromBodyMapTattooPiercings < ActiveRecord::Migration[7.1]
  def change
    remove_column :body_map_tattoo_piercings, :comments, :string
  end
end
