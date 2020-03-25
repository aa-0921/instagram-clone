class AddPictureToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :picture, :string
  end
end
