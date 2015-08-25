class CreateProject < ActiveRecord::Migration

  def up
    create_table :projects do |t|
      t.string :name
    end
    create_table :attributes do |t|
      t.string :name
      t.integer :project_id
    end
    create_table :components do |t|
      t.string :name
      t.integer :project_id
    end
    create_table :capabilities do |t|
      t.string :name
      t.integer :attribute_id
      t.integer :component_id
      t.integer :project_id
      t.boolean :active
    end
  end

  def down
    drop_table :projects
  end

end
