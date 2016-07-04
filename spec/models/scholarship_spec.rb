# == Schema Information
#
# Table name: scholarships
#
#  id                       :integer         not null, primary key
#  name                     :string(255)     default(""), not null
#  status_id                :integer         default(1), not null
#  end_date                 :datetime        not null
#  copy                     :text            default("")
#  terms                    :text            default("")
#  meta_description         :text
#  permalink                :string(255)     not null
#  created_at               :datetime        not null
#  updated_at               :datetime        not null
#  submission_format        :text            default("")
#  submission_prompt        :text            default("")
#  thank_you                :text            default("")
#  voting_start_date        :datetime
#  voting_end_date          :datetime
#  voting_title             :string(255)     default("Vote for the winner")
#  voting_copy              :text
#  high_school_label        :string(255)
#  or_label_text            :string(255)
#  description_instructions :string(255)
#  title_label              :string(255)
#  show_upload              :boolean         default(TRUE)
#  show_video_url           :boolean         default(TRUE)
#  show_or_label            :boolean         default(TRUE)
#  show_title               :boolean         default(TRUE)
#  require_authentication   :boolean         default(FALSE)
#  logged_in_copy           :text
#

require 'spec_helper'

describe Scholarship do
  pending "add some examples to (or delete) #{__FILE__}"
end
