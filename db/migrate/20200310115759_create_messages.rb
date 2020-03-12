class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :user_id
      t.integer :room_id
      t.boolean :read,  default: true, null: false
      t.timestamps
    end
  end
end
