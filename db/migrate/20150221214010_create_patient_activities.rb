class CreatePatientActivities < ActiveRecord::Migration
  def change
    create_table  :patient_activities do |t|
      t.integer   :patient_id
      t.integer   :patient_visit_id
      t.integer   :activity_id
      t.date      :activity_date
      #t.string    :body_part
      #t.boolean   :prescription_written
      #t.text      :prescription_notes
      #t.decimal   :amount_charged
      t.boolean :performed
      t.boolean :billable
      t.integer :amount

      t.timestamps null: false
    end
    
  end
end
