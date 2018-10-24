class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :permissions, array: true, default: []
      t.timestamps
    end
  end
end
