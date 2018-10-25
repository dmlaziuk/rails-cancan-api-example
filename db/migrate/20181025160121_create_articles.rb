class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.belongs_to :user
      t.string :title
      t.text :body
      t.timestamps
    end
  end
end
