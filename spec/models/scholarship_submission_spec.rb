# == Schema Information
#
# Table name: scholarship_submissions
#
#  id                          :integer         not null, primary key
#  first_name                  :string(255)     default(""), not null
#  last_name                   :string(255)     default(""), not null
#  high_school                 :string(255)     default(""), not null
#  year_in_school              :string(255)     default(""), not null
#  email                       :string(255)     default(""), not null
#  phone                       :string(255)     default(""), not null
#  state                       :string(255)     default(""), not null
#  birth_month                 :string(255)     default(""), not null
#  birth_year                  :string(255)     default(""), not null
#  not_currently_enrolled      :boolean
#  of_age_or_consent           :boolean
#  document_uid                :string(255)
#  document_name               :string(255)
#  video_url                   :string(255)     default("")
#  description                 :text
#  agree_to_terms              :boolean
#  scholarship_id              :integer         not null
#  created_at                  :datetime        not null
#  updated_at                  :datetime        not null
#  submission_format           :text            default("")
#  submission_prompt           :text            default("")
#  video_embed                 :text
#  thumbnail_uid               :string(255)
#  thumbnail_name              :string(255)
#  selected_entry              :boolean         default(FALSE)
#  user_submission_votes_count :integer         default(0)
#  school_type_id              :integer         default(0)
#  title                       :string(255)
#  order                       :integer         default(0)
#

require 'spec_helper'

describe ScholarshipSubmission do
  pending "add some examples to (or delete) #{__FILE__}"
end
