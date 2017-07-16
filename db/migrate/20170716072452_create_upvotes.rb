class CreateUpvotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.string :upvote_type
      t.integer :upvotetype_id

      t.timestamps null: false
    end
  end
end
