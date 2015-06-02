FactoryGirl.define do
  factory :patient_activity do
    patient_id ""
clinical_trial ""
activity_date "2015-02-21"
body_part "MyString"
prescription_written false
prescription_notes "MyText"
amount_charged "9.99"
  end

end
