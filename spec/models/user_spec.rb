# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer         default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  username               :string(255)     default(""), not null
#  status_id              :integer         default(2)
#  role_id                :integer         default(1), not null
#  custom_avatar_uid      :string(255)
#  custom_avatar_name     :string(255)
#  is_adviser             :boolean         default(FALSE)
#  accepts_tos            :boolean         default(TRUE)
#  set_up_profile         :boolean         default(FALSE)
#  verified_type_id       :integer         default(0)
#  system_avatar_id       :integer
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  borough_id             :integer
#  zipcode                :string(255)
#  bio                    :text
#

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end
