class RemovePlannedSpotIdFromCourses < ActiveRecord::Migration[7.1]
  def change
    remove_column :courses, :planned_spot_id, :integer
  end
end
