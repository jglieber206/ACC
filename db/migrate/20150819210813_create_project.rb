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
      t.integer :project_id
      t.integer :result_id
      t.string :code
      t.string :url
      t.string :oauth
      t.boolean :last_result
    end
    create_table :capability_maps do |t|
      t.integer :project_id
      t.integer :attribute_id
      t.integer :component_id
      t.integer :capability_id
    end
  end

  def down
    drop_table :projects
  end

end
