class ClinicalTrial < ActiveRecord::Base
  belongs_to :organization
  has_many :invoice, :dependent => :destroy
  has_many :activities
  belongs_to :trial_sponsor
  belongs_to :organization

  has_many :visits, :class_name => "ClinicalTrialVisit", :foreign_key => "clinical_trial_id"
  has_many :arms, :class_name => "Arm", :foreign_key => "clinical_trial_id"
  has_many :patients
  has_many :attachments, :class_name => "ClinicalTrialAttachment", :foreign_key => "clinical_trial_id"

  scope :my, ->(current_user) {
    where(:organization_id => current_user.organization_id)
  }


  belongs_to :phase, :class_name => "ClinicalTrialPhase", :foreign_key => "phase_id"
  belongs_to :ct_status, :class_name => "ClinicalTrialStatus", :foreign_key => "status_id"
  belongs_to :organ, :class_name => "ClinicalTrialOrgan", :foreign_key => "organ_id"
  belongs_to :disease_stage, :class_name => "DiseaseStage", :foreign_key => "disease_stage_id"
  belongs_to :masking, :class_name => "ClinicalTrialMasking", :foreign_key => "masking_id"
  belongs_to :overall_study_status, :class_name => "StudyStatus", :foreign_key => "overall_study_status_id"
  belongs_to :recruitment_status_at_facility, :class_name => "StudyStatus", :foreign_key => "recruitment_status_at_facility_id"


  validates_presence_of :trial_sponsor_id, :organization_id, :protocol_id, :study_title, :phase_id, :status_id,
                        :drug_name, :organ_id, :disease_stage_id, :official_study_title, :enrollment_begin_date,
                        :primary_completion_date, :study_completion_date, :masking_id, :overall_study_status_id,
                        :recruitment_status_at_facility_id, :principal_investigator, :clinical_assistant,
                        :start_date, :expected_trial_enrollment_count

end
