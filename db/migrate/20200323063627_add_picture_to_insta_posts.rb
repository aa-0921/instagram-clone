class AddPictureToInstaPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :insta_posts, :picture, :string
  end
end
