class CreateClinicalTrials < ActiveRecord::Migration
  def change
    create_table :clinical_trials do |t|
      t.integer :organization_id
      t.integer :trial_sponsor_id
      t.string :protocol_id
      t.string :study_title
      t.string :phase_id
      t.string :status_id
      t.string :drug_name
      t.string :organ_id
      t.integer :disease_stage_id
      t.string :study_acronym
      t.string :official_study_title
      t.string :secondary_ids
      t.date :enrollment_begin_date
      t.date :enrollment_end_date
      t.date :primary_completion_date
      t.date :study_completion_date
      t.integer :masking_id
      t.integer :overall_study_status_id
      t.integer :recruitment_status_at_facility_id
      t.string :principal_investigator
      t.string :clinical_assistant
      t.string :other_information
      t.date :start_date
      t.timestamps null: false
    end
  end
end
