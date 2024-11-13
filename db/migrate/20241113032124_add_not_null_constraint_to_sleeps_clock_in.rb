class AddNotNullConstraintToSleepsClockIn < ActiveRecord::Migration[8.0]
  def change
    change_column_null :sleeps, :clock_in, false
  end
end
