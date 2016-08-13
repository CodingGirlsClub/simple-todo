class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :remark
      t.boolean :is_finished

      t.timestamps
    end
  end
end
