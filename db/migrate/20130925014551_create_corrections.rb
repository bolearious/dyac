class CreateCorrections < ActiveRecord::Migration
  def change
    create_table :corrections do |t|
      t.integer :custom_word_id
      t.string :replacement
      t.timestamps
    end
    add_index :corrections, [:custom_word_id]
  end
end
