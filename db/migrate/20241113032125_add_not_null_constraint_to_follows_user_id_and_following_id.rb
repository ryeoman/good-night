class AddNotNullConstraintToFollowsUserIdAndFollowingId < ActiveRecord::Migration[8.0]
  def change
    change_column_null :follows, :user_id, false
    change_column_null :follows, :following_id, false
  end
end
