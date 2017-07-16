class CreateDownvotes < ActiveRecord::Migration
  def change
    create_table :downvotes do |t|
      t.string :downvote_type
      t.integer :downvotetype_id

      t.timestamps null: false
    end
  end
end
