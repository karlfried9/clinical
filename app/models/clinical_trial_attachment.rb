class ClinicalTrialAttachment < ActiveRecord::Base
  has_attached_file :content
  #validates_attachment :content, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  # Validate filename
  validates_attachment_file_name :content, :matches => [/png\Z/, /jpe?g\Z/, /pdf\Z/, /docx?\Z/, /xlsx?\Z/, /zip\Z/]

  do_not_validate_attachment_file_type :content
end
