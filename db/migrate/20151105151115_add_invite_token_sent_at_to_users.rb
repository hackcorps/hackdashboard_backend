class AddInviteTokenSentAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invite_token_sent_at, :datetime
  end
end
