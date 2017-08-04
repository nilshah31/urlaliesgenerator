class AddVisitCountToUrlGenerators < ActiveRecord::Migration[5.0]
  def change
    add_column :url_generators, :visit_count, :string, default: 0
  end
end
