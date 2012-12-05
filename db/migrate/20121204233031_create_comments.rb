class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :email
      t.string :website
      t.string :name
      t.string :ip
      t.text :body

      t.timestamps
    end
  end
end
