class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest

      t.timestamps
    end

    create_table :trips do |t|

      t.string :trip_name
      t.date :start_date
      t.date :end_date
      t.integer :days_left_till

      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
    create_table :places do |t|
      t.string :place_name
      t.belongs_to :trip, null: false, foreign_key: true
      t.timestamps
    end
  end
end
