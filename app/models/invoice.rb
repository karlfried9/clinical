class Invoice < ActiveRecord::Base
  acts_as_commentable
  # has_paper_trail

  belongs_to :clinical_trial
  has_many :payments, dependent: :destroy
  has_many :patient_activity_invoices, dependent: :destroy
  has_many :patient_activities, through: :patient_activity_invoices

  scope :my, ->(current_user) {
    where(:organization_id => current_user.organization_id)
  }

  accepts_nested_attributes_for :patient_activities

  state_machine :status, :initial => :draft do
    state :draft, :issued, :sent, :archived, :paid, :partially_paid, :cancelled

    event :issue do
      transition :draft => :issued
    end

    event :send_state do #send function is already used in rails
      transition :issued => :sent
    end

    event :archive do
      transition [:issued, :sent] => :archived
    end

    event :full_payment do
      transition [:sent, :partially_paid] => :paid
    end

    event :partial_payment do
      transition :sent => :partially_paid
    end

    event :cancel do
      transition :partially_paid => :cancelled
    end
  end
end
