class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :insta_post
      t.text :body

      t.timestamps
    end
    add_index :comments, [:user_id, :insta_post_id, :created_at]
  end
end
