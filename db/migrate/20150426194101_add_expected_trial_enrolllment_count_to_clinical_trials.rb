class AddExpectedTrialEnrolllmentCountToClinicalTrials < ActiveRecord::Migration
  def change
    add_column :clinical_trials, :expected_trial_enrollment_count, :integer
  end
end
