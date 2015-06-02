class Organization < ActiveRecord::Base
  has_one :clinical_trial
  has_many :users
end
