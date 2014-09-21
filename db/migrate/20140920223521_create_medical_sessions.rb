class CreateMedicalSessions < ActiveRecord::Migration
  def change
    create_table :medical_sessions do |t|

      t.timestamps
    end
  end
end
