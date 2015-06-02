FactoryGirl.define do
  factory :role do
    name "Doctor"
    description "Doctor"
  end
  factory :role_doctor, class: Role do
    name "Doctor"
    description "Doctor"
  end
  factory :role_clinic_manager, class: Role do
    name "Clinic Manager"
    description "Clinic Manager"
  end
  factory :role_super_admin, class: Role do
    name "Super Admin"
    description "Super Admin"
  end
end
