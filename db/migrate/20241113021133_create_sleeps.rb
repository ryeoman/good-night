class CreateSleeps < ActiveRecord::Migration[8.0]
  def change
    create_table :sleeps do |t|
      t.references :user, null: false, foreign_key: true
      t.timestamp :clock_in
      t.timestamp :clock_out
      t.bigint :duration

      t.timestamps
    end
  end
end
