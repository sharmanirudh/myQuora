class CreateDownvotes < ActiveRecord::Migration
  def change
    create_table :downvotes do |t|
      t.string :downvote_type
      t.integer :downvotetype_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
