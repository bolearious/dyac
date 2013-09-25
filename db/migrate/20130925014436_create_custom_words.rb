class CreateCustomWords < ActiveRecord::Migration
  def change
    create_table :custom_words do |t|
      t.integer :user_id
      t.string :word
      t.boolean :correct
      t.timestamps
    end
    
    add_index :custom_words, [:user_id, :word]
  end
end
