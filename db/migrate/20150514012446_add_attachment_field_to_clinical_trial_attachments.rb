class AddAttachmentFieldToClinicalTrialAttachments < ActiveRecord::Migration
  def change
    add_attachment :clinical_trial_attachments, :content
  end

  def self.down
    add_attachment :clinical_trial_attachments, :content
  end
end
