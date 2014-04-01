class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :crypted_password
      t.string :salt
      t.integer :role_id

      t.timestamps
    end
  end
end
