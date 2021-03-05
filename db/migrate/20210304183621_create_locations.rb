# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :x_parent
      t.integer :num_children
      t.boolean :inactive
      t.string :organization
      t.string :name
      t.string :addr1
      t.string :addr2
      t.string :vaccines
      t.string :logo
      t.string :map_zoom
      t.string :notes
      t.string :notes_spn
      t.string :alt
      t.string :alt_spn
      t.string :date
      t.string :time
      t.string :link
      t.string :second_dose
      t.string :full
      t.string :comments
      t.string :comments_spn
      t.string :times
      t.string :clinic_format
      t.string :system

      t.timestamps
    end
  end
end
