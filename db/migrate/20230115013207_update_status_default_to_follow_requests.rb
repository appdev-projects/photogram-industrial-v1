class UpdateStatusDefaultToFollowRequests < ActiveRecord::Migration[6.1]
  def change
    change_column_default :follow_requests, :status, from: nil, to: "pending"
  end
end
