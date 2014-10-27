class AddHelpfulToReview < ActiveRecord::Migration
  def change
    add_column :spree_reviews, :is_helpful, :integer, :default => 0
    add_column :spree_reviews, :non_helpful, :integer, :default => 0
  end
end
