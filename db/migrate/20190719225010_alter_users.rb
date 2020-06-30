class AlterUsers < ActiveRecord::Migration[5.2]
  def up
    rename_table("users", "admin_users")
    add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    change_column("admin_users", "email", :string, :limit => 100)
    rename_column("admin_users", "password", "hashed_password")
    puts "*** Adding an index ***"
    add_index("admin_users", "username") # add_index on all your foreign keys and also on any column which is used frequently for looking up records
  end

  def down
    # same items as above, reverse order, apply opposite operations, LOOK CAREFULLY
    remove_index("admin_users", "username")
    rename_column("admin_users", "hashed_password", "password")
    change_column("admin_users", "email", :string, :default => '', :null => false) # default from "class CreateUsers < ActiveRecord::Migration"
    remove_column("admin_users", "username")
    rename_table("admin_users", "users")
  end

end
