# == Schema Information
#
# Table name: user_newsletters
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  newsletter_id :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class UserNewsletter < ActiveRecord::Base

  belongs_to :user
  belongs_to :newsletter

  after_create :subscribe
  after_destroy :unsubscribe

  attr_accessible :user_id, :newsletter_id

  def subscribe
    site_setting = SiteSetting.first
    gb = Gibbon::API.new(site_setting.mc_api_key)
    begin
      gb.lists.subscribe({
        id: newsletter.mc_list_id,
        email: {email: user.email },
        double_optin: false
      })
    rescue
      logger.error "could not subscribe #{user.email}"
    end
  end

  def unsubscribe
    site_setting = SiteSetting.first
    begin
      gb = Gibbon::API.new(site_setting.mc_api_key)
      gb.lists.unsubscribe(
        id: newsletter.mc_list_id,
        email: { email: user.email },
        delete_member: true, send_notify: true
      )
    rescue
      logger.error "#{user.email} not subscribed"
    end
  end
end
