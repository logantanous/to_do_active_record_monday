class CreateTasksDevelopmentFile < ActiveRecord::Migration[5.1]
  def change
    create_table(:tasks) do |t|
      t.column(:description, :string)

      t.timestamps()
    end
    add_columnn(:tasks, :list_id, :integer)

  end
end
