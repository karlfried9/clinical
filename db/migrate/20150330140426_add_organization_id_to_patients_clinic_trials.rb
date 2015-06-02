class AddOrganizationIdToPatientsClinicTrials < ActiveRecord::Migration
  def change
    add_column :patients, :organization_id, :integer
  end
end
