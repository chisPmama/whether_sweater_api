class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :password_confirmation
      t.string :api_key, default: nil

      t.timestamps
    end
  end
end
