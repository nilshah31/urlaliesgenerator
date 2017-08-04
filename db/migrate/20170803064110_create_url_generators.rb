class CreateUrlGenerators < ActiveRecord::Migration[5.0]
  def change
    create_table :url_generators do |t|
      t.string :url
      t.string :key

      t.timestamps
    end
  end
end
