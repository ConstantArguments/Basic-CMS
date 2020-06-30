class CreateAdminUsersPagesJoin < ActiveRecord::Migration[5.2]

  def up
    # note table name does not have join at end; removed
    # we don't need an id on this table. We're not gonna actually be instantiating this at any point,
      # there's no time that we're gonna bring up an AdminUsers-Pages object
    create_table :admin_users_pages, :id => false do |t|
      t.integer "admin_user_id"
      t.integer "page_id"
    end
    # index for both columns together inside an array
    add_index("admin_users_pages", ["admin_user_id", "page_id"])
  end

  def down
    drop_table :admin_users_pages
  end

end
