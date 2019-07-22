class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :content
      t.belongs_to :article, foreign_key: true
      t.integer :status, default:'unpublished'
      t.timestamps
    end
  end
end
