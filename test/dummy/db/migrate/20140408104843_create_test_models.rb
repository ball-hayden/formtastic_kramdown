class CreateTestModels < ActiveRecord::Migration
  def change
    create_table :test_models do |t|
      t.text :body

      t.timestamps
    end
  end
end
