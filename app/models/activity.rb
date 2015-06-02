class Activity < ActiveRecord::Base
  belongs_to :type, class_name:"ActivityType", foreign_key: "type_id"
  belongs_to :organization
  acts_as_taggable
  acts_as_taggable_on :category

  validates_presence_of :type_id, :organization_id, :name, :amount
end
