# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#create user roles
r1 = Role.create({name: "Doctor", description: "Doctor"})
r2 = Role.create({name: "Clinic Manager", description: "Clinic Manager"})
r3 = Role.create({name: "Super Admin", description: "Super Admin"})

# create super admin user
admin_user = CreateAdminService.new.call

# create organization
org1 = Organization.create({name: "Organization1"})
org2 = Organization.create({name: "Organization2"})

# create clinic manager and doctor
admin_user.update_column(:role_id, r3.id)
#puts 'CREATED ADMIN USER: ' << user.email
clinic_manager = User.create({email: "clinic_manager@example.com", password: "changeme", password_confirmation: "changeme", role_id: r2.id, organization_id: org1.id})
clinic_manager = User.create({email: "clinic_manager1@example.com", password: "changeme", password_confirmation: "changeme", role_id: r2.id, organization_id: org2.id})

doctor = User.create({name: "Nicolas", email: "doctor1@example.com", password: "changeme", password_confirmation: "changeme", role_id: r1.id, organization_id: org1.id})
doctor = User.create({name: "Marie", email: "doctor2@example.com", password: "changeme", password_confirmation: "changeme", role_id: r1.id, organization_id: org1.id})
doctor = User.create({name: "Marc", email: "doctor3@example.com", password: "changeme", password_confirmation: "changeme", role_id: r1.id, organization_id: org1.id})

# clinical_trial_visit_type
type1 = ClinicalTrialVisitType.create({name: 'Enrollment'})
type2 = ClinicalTrialVisitType.create({name: 'Follow-up'})
type3 = ClinicalTrialVisitType.create({name: 'Early termination'})
type4 = ClinicalTrialVisitType.create({name: 'End of Study'})

# clinical_trial_ visit format
cf1 = ClinicalTrialVisitFormat.create({name: 'In-person'})
cf2 = ClinicalTrialVisitFormat.create({name: 'Phone Call'})
cf3 = ClinicalTrialVisitFormat.create({name: 'other'})


# disease_stage for clinical trial
stage1 = DiseaseStage.create({name: 'Stage 0', description: 'Early form'})
stage2 = DiseaseStage.create({name: 'Stage I', description: 'Localized'})
stage3 = DiseaseStage.create({name: 'Stage II', description: 'Early Locally Advanced'})
stage4 = DiseaseStage.create({name: 'Stage III', description: 'Late Locally Advanced'})
stage5 = DiseaseStage.create({name: 'Stage IV', description: 'Metastasized'})

# study status
st1 = StudyStatus.create({code: 'study_not_yet_recruiting', name: 'Not yet recruiting'})
st2 = StudyStatus.create({code: 'study_recruiting', name: 'Recruiting'})
st3 = StudyStatus.create({code: 'study_enrolling_by_invitation', name: 'Enrolling by invitation'})
st4 = StudyStatus.create({code: 'study_active_not_recruiting', name: 'Active, not recruiting (study ongoing)'})
st5 = StudyStatus.create({code: 'study_completed', name: 'Completed (study concluded normally)'})
st6 = StudyStatus.create({code: 'study_suspended', name: 'Suspended (potentially could be resumed)'})
st7 = StudyStatus.create({code: 'study_terminated', name: 'Terminated (prematurely halted, participants no longer being examined/treated)'})
st8 = StudyStatus.create({code: 'study_withdrawn', name: 'Withdrawn (study halted prior to enrollment of first participant)'})

# clinical trial masking
mask1 = ClinicalTrialMasking.create({name: 'Open'})
mask2 = ClinicalTrialMasking.create({name: 'Single'})
mask3 = ClinicalTrialMasking.create({name: 'Blind'})
mask4 = ClinicalTrialMasking.create({name: 'Double Blind'})

# activity types
#Procedure’,’Diagnosis’, ‘Drug’, ‘Other'
at1 = ActivityType.create({name: 'Procédure'})
at2 = ActivityType.create({name: 'Diagnostique'})
at3 = ActivityType.create({name: 'Médicament'})
at4 = ActivityType.create({name: 'Autre'})

# clinical Trial phase
cp1 = ClinicalTrialPhase.create({name: 'Phase I'})
cp2 = ClinicalTrialPhase.create({name: 'Phase IIa'})
cp3 = ClinicalTrialPhase.create({name: 'Phase IIb'})
cp4 = ClinicalTrialPhase.create({name: 'Phase III'})

# clinical_trial status
cts1 = ClinicalTrialStatus.create({name: 'Created'})
cts2 = ClinicalTrialStatus.create({name: 'Being selected'})
cts3 = ClinicalTrialStatus.create({name: 'Selection complete'})
cts4 = ClinicalTrialStatus.create({name: 'Open for Patient Enrollment'})
cts4 = ClinicalTrialStatus.create({name: 'Closed for Enrollment'})
cts4 = ClinicalTrialStatus.create({name: 'On hold'})

# clinical trial organ
cto1 = ClinicalTrialOrgan.create({name: 'lungs'})
cto2 = ClinicalTrialOrgan.create({name: 'head'})
cto3 = ClinicalTrialOrgan.create({name: 'brain'})
cto4 = ClinicalTrialOrgan.create({name: 'liver'})
cto5 = ClinicalTrialOrgan.create({name: 'colon'})
cto6 = ClinicalTrialOrgan.create({name: 'breast'})

# sponsors
sponsor1 = TrialSponsor.create({name: "Pfizer", contact_info: "23-25 Avenue du Docteur Lannelongue, 75014 Paris, France"})
sponsor2 = TrialSponsor.create({name: "GSK", contact_info: "9 Rue des Rosiers, Paris 04, France"})
sponsor2 = TrialSponsor.create({name: "Sanofi France", contact_info: "9 Boulevard Romain Rolland, Paris, France"})

# clinical trial  
ct1 = ClinicalTrial.create({
  organization_id: org1.id,
  trial_sponsor_id: sponsor2.id,
  protocol_id: 'CTPROTID0808',
  study_title: 'Sample Lung Cancer Trial',
  phase_id: cp2.id,
  status_id: st2.id,
  drug_name: 'Lung Cancerl Drug LC123',
  organ_id: cto1.id,
  disease_stage_id: stage3.id,
  study_acronym: 'Lung Cancer LC123',
  official_study_title: 'Sample Lunch Cancer Official Title',
  secondary_ids: 'XYZ01',
  expected_trial_enrollment_count: 60,
  enrollment_begin_date: DateTime.new(2015,2,1),
  enrollment_end_date: DateTime.new(2015,5,15),
  primary_completion_date: DateTime.new(2016,2,1),
  study_completion_date: DateTime.new(2016,7,15),
  masking_id: mask3.id,
  overall_study_status_id: cts2.id,
  recruitment_status_at_facility_id: cts2.id,
  principal_investigator: 'Dr. Prima',
  clinical_assistant: 'Mr. Jack',
  other_information: 'Other information about the trial',
  start_date: DateTime.new(2015,2,1),
  billing_to: "23-25 Avenue du Docteur Lannelongue, 75014 Paris, France",
  bill_to_email: "pfizer_billing_lung_cancer_cro@example.com"
  })

# clinical trial arms
cr_arm1 = Arm.create({name: "Arm A - Experimental", description: "some description here", clinical_trial_id: ct1.id})
cr_arm2 = Arm.create({name: "Arm B - Standard of Care", description: "some description here", clinical_trial_id: ct1.id})

# patients
patient1 = Patient.create({
  salutation: "Mr",
  first_name: "Jorge",
  last_name: "Lacra",
  patient_id: "pat0001",
  date_of_birth: DateTime.new(1955,5,5),
  notes: "some notes here",
  clinical_trial_id: ct1.id,
  arm_id: cr_arm1.id,
  organization_id: org1.id})

patient2 = Patient.create({
  salutation: "Mr",
  first_name: "Sal",
  last_name: "Alexnder",
  patient_id: "pat0002",
  date_of_birth: DateTime.new(1944,4,4),
  notes: "some notes about Sal Alexander here",
  clinical_trial_id: ct1.id,
  arm_id: cr_arm2.id,
  organization_id: org1.id})

# activitie:
activity1 = Activity.create({
  organization_id: org1.id,
  name: "Consent discussion",
  type_id: at4.id,
  billable: 1,
  amount: 100, 
  code_type: "OTHER",
  code: "0005",
  currency_code: "EU",
  description: "Patient consent form and answer questions related to the trial"
  })
  
activity2 = Activity.create({
  organization_id: org1.id,
  name: "XRay",
  type_id: at1.id,
  billable: 1,
  amount: 50, 
  code_type: "PROC",
  code: "0001",
  currency_code: "EU",
  description: "Standard xray"
  })
activity3 = Activity.create({
  organization_id: org1.id,
  name: "Vitals",
  type_id: at1.id,
  billable: 1,
  amount: 200, 
  code_type: "PROC",
  code: "0002",
  currency_code: "EU",
  description: "Take patient vitals"
  })
activity4 = Activity.create({
  organization_id: org1.id,
  name: "Administer drug",
  type_id: at3.id,
  billable: 1,
  amount: 250, 
  code_type: "PROC",
  code: "0003",
  currency_code: "EU",
  description: "Administer drug specified by the arm"
  })
activity4 = Activity.create({
  organization_id: org1.id,
  name: "Radiation",
  type_id: at3.id,
  billable: 1,
  amount: 500, 
  code_type: "PROC",
  code: "0004",
  currency_code: "EU",
  description: "Administer radiation"
  })

# Clinical Trial Visit
ct_visit_enrollment = ClinicalTrialVisit.create({
  clinical_trial_id: ct1.id,
  name: "Enrollment",
  description: "Baseline screening and enrollment with consent",
  type_id: type1.id,
  format_id: cf1.id,
  })
  
         