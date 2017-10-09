class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :mobile
      t.string :validate_code
      t.string :password_digest

      t.timestamps
    end
  end
end
