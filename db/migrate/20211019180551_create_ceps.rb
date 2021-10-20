class CreateCeps < ActiveRecord::Migration[6.1]
  def change
    create_table :ceps do |t|
      t.string :zip_code
      t.string :state
      t.string :city
      t.string :neighborhood
      t.string :address
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
