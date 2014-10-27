class CreateReviewHelpfuls < ActiveRecord::Migration
  def change
    create_table :review_helpfuls do |t|
      t.integer :review_id
      t.boolean :is_helpful

      t.timestamps
    end
  end
end
