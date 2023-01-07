class UpdateCommentsFieldUser < ActiveRecord::Migration[7.0]
  def self.up
    change_table :comments do |t|
      t.change :user_id, :integer, null: true
    end
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
