class DropReviewHelpfuls < ActiveRecord::Migration
  def change
    drop_table :review_helpfuls
  end
end
