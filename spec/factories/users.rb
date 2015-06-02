FactoryGirl.define do
  factory :user do
    name "Test Doctor User"
    email "doctor@example.com"
    password "please123"
    association :role, factory: :role
  end

  factory :doctor, class: User do
    name "Test Doctor User"
    email "doctor@example.com"
    password "please123"
    association :role, factory: :role_doctor
  end

  factory :clinic_manager, class: User do
    name "Test User"
    email "test@example.com"
    password "please123"
    association :role, factory: :role_clinic_manager
  end

  factory :super_admin, class: User do
    name "Test User"
    email "test@example.com"
    password "please123"
    association :role, factory: :role_super_admin
  end

end
