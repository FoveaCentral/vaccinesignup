class CreateUserZips < ActiveRecord::Migration[6.1]
  def change
    create_table :user_zips do |t|
      t.bigint :user_id, index: true, unique: true
      t.string :zip, foreign_key: true, index: true

      t.timestamps
    end
  end
end
