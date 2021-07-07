class AddLikesCountToInstaPosts < ActiveRecord::Migration[6.0]
 class MigrationUser < ApplicationRecord
    self.table_name = :insta_posts
  end

  def up
    _up
  rescue => e
    _down
    raise e
  end

  def down
    _down
  end

  private

  def _up
    MigrationUser.reset_column_information

    add_column :insta_posts, :likes_count, :integer, null: false, default: 0 unless column_exists? :insta_posts, :likes_count
  end

  def _down
    MigrationUser.reset_column_information

    remove_column :insta_posts, :likes_count if column_exists? :insta_posts, :likes_count
  end
end
