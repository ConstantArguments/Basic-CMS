class CreateUsers < ActiveRecord::Migration[5.2]
  # changed method from change to up and down
  def up
    create_table :users do |t| # rails will automatically add column for ID unless ":id => false" added to create_table

      t.column "first_name", :string, :limit => 25 # longhand for creating a column with the string type with size limit of 25 characters
      t.string "last_name", :limit => 50 # shorthand syntax for creating a column with the string type
      t.string "email", :default => '', :null => false
      t.string "password", :limit => 40

      t.timestamps # shorthand for the t.datetime columns below
      # Rails is automatically going to populate and update if named create_at or updated_at
      # t.datetime "created_at"
      # t.datetime "updated_at"

    end
  end

  def down
    drop_table :users  #note: drop_table
  end

end
