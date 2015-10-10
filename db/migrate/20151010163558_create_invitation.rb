class CreateInvitation < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
	    t.string :email
    end
  end
end
