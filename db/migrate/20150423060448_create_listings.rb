class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :address
      t.string :alt
      t.string :category
      t.text :description
      t.string :directions
      t.string :hours
      t.float :lat
      t.float :long
      t.string :name
      t.float :price
      t.string :tag
      t.string :url
      t.string :phone
      t.string :email
      t.string :fax
      t.string :image1
      t.string :image2
      t.string :image3

      t.timestamps null: false
    end
  end
end
