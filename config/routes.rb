Rails.application.routes.draw do
  resources :patient_visits do
    collection do
      get :search
      get :load_visit
      post :add_visit_schedule
    end
  end

  get 'patient_visits/:patient_id/:clinical_trial_visit_id/record_visit', to: 'patient_visits#record_visit', as: :record_visit_patient_visits
  post 'patient_visits/:patient_id/:clinical_trial_visit_id/new_visit', to: 'patient_visits#new_visit', as: :new_visit_patient_visits
  get 'patient_visits/:patient_id/:clinical_trial_visit_id/edit_visit', to: 'patient_visits#edit_visit', as: :edit_visit_patient_visits
  post 'patient_visits/:patient_id/:clinical_trial_visit_id/update_visit', to: 'patient_visits#update_visit', as: :update_visit_patient_visits
  get 'patient_visits/:patient_id/:clinical_trial_visit_id/show_visit', to: 'patient_visits#show_visit', as: :show_visit_patient_visits


  resources :clinical_trial_visits do
    get :autocomplete_clinical_trial_visit_name, :on => :collection
  end

  resources :activities do
    get :autocomplete_activity_name, :on => :collection
  end


  resources :organizations

  resources :roles

  resources :payments

  resources :invoices do
    collection do
      get :clinical_trial_billinginfo
      post :record_payment
    end

    member do
      post :add_comment
      get :issue
      get :send_state
      get :archive
      # post :record_payment
      get :cancel

      get :generate_pdf, format: 'pdf'
    end
  end

  resources :activities

  resources :patients

  resources :trial_sponsors

  resources :clinical_trials do
    member do
      get :manage_arms
      post :add_arm
      get :manage_visits
      get :new_visit
      post :add_visit
    end
    collection do
      get :load_arms
      get :load_patients
    end
  end

  # clinical trial arm path
  post 'clinical_trials/:id/destroy_arm/:arm_id', to: 'clinical_trials#destroy_arm', as: :destroy_arm
  post 'clinical_trials/:id/update_arm/:arm_id', to: 'clinical_trials#update_arm', as: :update_arm

  # clinical trial visit path
  post 'clinical_trials/:id/destroy_visit/:visit_id', to: 'clinical_trials#destroy_visit', as: :destroy_visit_clinical_trial
  get 'clinical_trials/:id/edit_visit/:visit_id', to: 'clinical_trials#edit_visit', as: :edit_visit_clinical_trial
  post 'clinical_trials/:id/update_visit/:visit_id', to: 'clinical_trials#update_visit', as: :update_visit_clinical_trial
  get 'clinical_trials/:id/show_visit/:visit_id', to: 'clinical_trials#show_visit', as: :show_visit_clinical_trial

  # clinical trial attachment path
  post 'clinical_trials/:id/add_attachment', to: 'clinical_trials#add_attachment', as: :clinical_trial_add_attachment
  get 'clinical_trials/:id/remove_attachment/:attachment_id', to: 'clinical_trials#remove_attachment', as: :clinical_trial_remove_attachment

  root to: 'visitors#index'

  # Reports
  get 'reports', to: 'patient_activities#reports_home'
  get 'monthly_charge_report', to: 'patient_activities#monthly_charge_report', as: :monthly_charge_report
  get 'trial_progress_report', to: 'patient_activities#reports_clinical_trial_progress_report', as: :trial_progress_report

  get 'users/new_doctor', to: 'users#new_doctor', as: :new_doctor
  get 'users/new_clinic_manager', to: 'users#new_clinic_manager', as: :new_clinic_manager
  post 'users/create_user', to: 'users#create_user', as: :create_user

  # Excel exports
  get 'patient_list', to: 'patients#patient_list', as: :excel_patient_list

  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users

end
