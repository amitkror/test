# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20160525072001) do

  create_table "assets", :force => true do |t|
    t.string   "title",           :default => ""
    t.string   "alt",             :default => ""
    t.integer  "page_id"
    t.string   "link"
    t.string   "attachment_uid",                     :null => false
    t.string   "attachment_name",                    :null => false
    t.boolean  "is_image",        :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "assets", ["page_id"], :name => "index_assets_on_page_id"

  create_table "audiences", :force => true do |t|
    t.string   "name",                                 :null => false
    t.string   "name_plural"
    t.integer  "order",             :default => 0
    t.boolean  "show_in_filters",   :default => true
    t.boolean  "show_in_settings",  :default => true
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "display_user_text", :default => false
    t.string   "placeholder_text"
    t.integer  "newsletter_id"
  end

  create_table "avatars", :force => true do |t|
    t.string   "name",                      :null => false
    t.string   "image_uid",                 :null => false
    t.string   "image_name",                :null => false
    t.integer  "order",      :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "blog_post_audiences", :force => true do |t|
    t.integer  "blog_post_id", :null => false
    t.integer  "audience_id",  :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "blog_post_audiences", ["audience_id"], :name => "index_blog_post_audiences_on_audience_id"
  add_index "blog_post_audiences", ["blog_post_id"], :name => "index_blog_post_audiences_on_blog_post_id"

  create_table "blog_posts", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "status_id"
    t.string   "image_uid"
    t.string   "image_name"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "comments_count"
    t.datetime "last_commented_at"
    t.integer  "last_commenter_id"
    t.text     "tagline"
    t.string   "meta_title"
    t.string   "meta_keywords"
    t.string   "meta_description"
  end

  add_index "blog_posts", ["user_id"], :name => "index_blog_posts_on_user_id"

  create_table "blog_posts_tags", :force => true do |t|
    t.integer "blog_post_id"
    t.integer "tag_id"
  end

  create_table "bookmarks", :force => true do |t|
    t.integer  "user_id",                    :null => false
    t.integer  "folder_id",                  :null => false
    t.integer  "resource_id",                :null => false
    t.integer  "order",       :default => 0
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "bookmarks", ["folder_id"], :name => "index_bookmarks_on_folder_id"
  add_index "bookmarks", ["resource_id"], :name => "index_bookmarks_on_resource_id"
  add_index "bookmarks", ["user_id"], :name => "index_bookmarks_on_user_id"

  create_table "boroughs", :force => true do |t|
    t.string   "name",                               :null => false
    t.integer  "order",            :default => 0
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "show_in_filters",  :default => true
    t.boolean  "show_in_settings", :default => true
  end

  create_table "campaign_ppcs", :force => true do |t|
    t.string   "title"
    t.string   "body"
    t.string   "permalink"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "status_id"
    t.string   "image_name"
    t.string   "image_uid"
    t.string   "meta_description"
    t.string   "meta_title"
    t.string   "meta_keywords"
    t.string   "advertisement_image_link"
    t.string   "contact_form_email"
  end

  add_index "campaign_ppcs", ["permalink"], :name => "index_campaign_ppcs_on_permalink", :unique => true

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "guest_user_id"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["guest_user_id"], :name => "index_comments_on_guest_user_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "conditions_of_uses", :force => true do |t|
    t.string   "title",      :null => false
    t.text     "copy",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contact_submissions", :force => true do |t|
    t.string   "title",      :null => false
    t.string   "name",       :null => false
    t.string   "email",      :null => false
    t.text     "message",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contests", :force => true do |t|
    t.string   "name",                                                            :null => false
    t.date     "start_date",                                                      :null => false
    t.date     "end_date",                                                        :null => false
    t.text     "body",                                                            :null => false
    t.boolean  "is_active"
    t.integer  "email_trigger_count",                                             :null => false
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
    t.text     "sub_text"
    t.string   "bullet_1",            :default => "Generate your code to begin!"
    t.string   "bullet_2",            :default => "Share your link!"
    t.string   "bullet_3",            :default => "Watch your referrals."
    t.string   "generate_text",       :default => "Generate your code to begin!"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "event_audiences", :force => true do |t|
    t.integer  "event_id",    :null => false
    t.integer  "audience_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "event_audiences", ["audience_id"], :name => "index_event_audiences_on_audience_id"
  add_index "event_audiences", ["event_id"], :name => "index_event_audiences_on_event_id"

  create_table "event_boroughs", :force => true do |t|
    t.integer  "event_id"
    t.integer  "borough_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "event_boroughs", ["borough_id"], :name => "index_event_boroughs_on_borough_id"
  add_index "event_boroughs", ["event_id"], :name => "index_event_boroughs_on_event_id"

  create_table "event_subway_lines", :force => true do |t|
    t.integer  "event_id"
    t.integer  "subway_line_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "event_subway_lines", ["event_id"], :name => "index_event_subway_lines_on_event_id"
  add_index "event_subway_lines", ["subway_line_id"], :name => "index_event_subway_lines_on_subway_line_id"

  create_table "events", :force => true do |t|
    t.string   "name",                                   :null => false
    t.datetime "start_datetime",                         :null => false
    t.datetime "end_datetime"
    t.string   "organization"
    t.string   "website"
    t.string   "cost_text"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "contact_phone_number"
    t.string   "location"
    t.string   "street"
    t.string   "city"
    t.string   "state",                :default => "NY"
    t.string   "postal_code"
    t.text     "body",                                   :null => false
    t.string   "logo_uid"
    t.string   "logo_name"
    t.string   "attachment_uid"
    t.string   "attachment_name"
    t.string   "attachment_label"
    t.integer  "status_id",            :default => 1
    t.string   "permalink",                              :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "last_commented_at"
    t.integer  "last_commenter_id"
    t.integer  "comments_count",       :default => 0
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "events", ["last_commenter_id"], :name => "index_events_on_last_commenter_id"
  add_index "events", ["permalink"], :name => "index_events_on_permalink", :unique => true
  add_index "events", ["status_id"], :name => "index_events_on_status_id"

  create_table "faq_audiences", :force => true do |t|
    t.integer  "faq_id",      :null => false
    t.integer  "audience_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "faq_audiences", ["audience_id"], :name => "index_faq_audiences_on_audience_id"
  add_index "faq_audiences", ["faq_id"], :name => "index_faq_audiences_on_faq_id"

  create_table "faq_sets", :force => true do |t|
    t.string   "name"
    t.integer  "faq_set_id"
    t.integer  "status_id",  :default => 1
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "faq_sets", ["faq_set_id"], :name => "index_faq_sets_on_faq_set_id"
  add_index "faq_sets", ["status_id"], :name => "index_faq_sets_on_status_id"

  create_table "faqs", :force => true do |t|
    t.text     "question",                       :null => false
    t.text     "answer",                         :null => false
    t.integer  "status_id",       :default => 1
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "page_faqs_count", :default => 0
  end

  add_index "faqs", ["status_id"], :name => "index_faqs_on_status_id"

  create_table "folder_emails", :force => true do |t|
    t.integer  "folder_id",  :null => false
    t.integer  "user_id",    :null => false
    t.string   "recipient",  :null => false
    t.string   "subject",    :null => false
    t.text     "message"
    t.boolean  "cc_me"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "folder_emails", ["folder_id"], :name => "index_folder_emails_on_folder_id"
  add_index "folder_emails", ["user_id"], :name => "index_folder_emails_on_user_id"

  create_table "folder_recommendations", :force => true do |t|
    t.integer  "folder_id"
    t.text     "description"
    t.string   "demographic"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "folder_recommendations", ["folder_id"], :name => "index_folder_recommendations_on_folder_id"

  create_table "folders", :force => true do |t|
    t.integer  "user_id",                            :null => false
    t.string   "name",                               :null => false
    t.integer  "order",           :default => 0
    t.integer  "bookmarks_count", :default => 0
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "is_featured",     :default => false
    t.text     "description"
    t.string   "slug"
  end

  add_index "folders", ["user_id"], :name => "index_folders_on_user_id"

  create_table "forum_audiences", :force => true do |t|
    t.integer  "forum_id",    :null => false
    t.integer  "audience_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "forum_audiences", ["audience_id"], :name => "index_forum_audiences_on_audience_id"
  add_index "forum_audiences", ["forum_id"], :name => "index_forum_audiences_on_forum_id"

  create_table "forum_threads", :force => true do |t|
    t.integer  "forum_id",                         :null => false
    t.integer  "user_id",                          :null => false
    t.string   "name",                             :null => false
    t.string   "permalink",                        :null => false
    t.integer  "status_id",         :default => 1
    t.text     "message"
    t.datetime "last_commented_at"
    t.integer  "last_commenter_id"
    t.integer  "comments_count",    :default => 0
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "forum_threads", ["forum_id"], :name => "index_forum_threads_on_forum_id"
  add_index "forum_threads", ["last_commenter_id"], :name => "index_forum_threads_on_last_commenter_id"
  add_index "forum_threads", ["permalink"], :name => "index_forum_threads_on_permalink", :unique => true
  add_index "forum_threads", ["user_id"], :name => "index_forum_threads_on_user_id"

  create_table "forums", :force => true do |t|
    t.string   "name",                               :null => false
    t.string   "permalink",                          :null => false
    t.integer  "status_id",           :default => 1
    t.integer  "forum_threads_count", :default => 0
    t.integer  "order",               :default => 0
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "forums", ["permalink"], :name => "index_forums_on_permalink", :unique => true

  create_table "galleries", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "gallery_assets", :force => true do |t|
    t.integer  "gallery_id",                :null => false
    t.integer  "asset_id",                  :null => false
    t.integer  "order",      :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "gallery_assets", ["asset_id"], :name => "index_gallery_assets_on_asset_id"
  add_index "gallery_assets", ["gallery_id"], :name => "index_gallery_assets_on_gallery_id"

  create_table "glossary_imports", :force => true do |t|
    t.string   "attachment_uid"
    t.string   "attachment_name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "glossary_terms", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "url"
    t.text     "definition", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guest_questions", :force => true do |t|
    t.integer  "guest_user_id",                              :null => false
    t.integer  "adviser_id"
    t.text     "question"
    t.boolean  "answered",                :default => false
    t.boolean  "accepts_tos",             :default => true
    t.boolean  "new_comment_for_user",    :default => false
    t.boolean  "new_for_adviser",         :default => false
    t.boolean  "new_comment_for_adviser", :default => false
    t.datetime "last_commented_at"
    t.integer  "last_commenter_id"
    t.integer  "comments_count",          :default => 0
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "guest_questions", ["adviser_id"], :name => "index_guest_questions_on_adviser_id"
  add_index "guest_questions", ["guest_user_id"], :name => "index_guest_questions_on_guest_user_id"

  create_table "guest_users", :force => true do |t|
    t.string   "email",       :null => false
    t.string   "zipcode"
    t.string   "secret_code", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "home_slides", :force => true do |t|
    t.string   "image_uid"
    t.string   "image_name"
    t.integer  "order"
    t.string   "url"
    t.integer  "page_id"
    t.integer  "site_setting_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "home_slides", ["page_id"], :name => "index_home_slides_on_page_id"
  add_index "home_slides", ["site_setting_id"], :name => "index_home_slides_on_site_setting_id"

  create_table "languages", :force => true do |t|
    t.string   "name",                      :null => false
    t.integer  "order",      :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "newsletters", :force => true do |t|
    t.string   "name",                              :null => false
    t.string   "mc_template_name"
    t.string   "mc_template_id"
    t.string   "mc_list_name"
    t.string   "mc_list_id"
    t.datetime "last_sent_at"
    t.text     "mc_interest_groups"
    t.integer  "status_id",          :default => 1, :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "organizations", :force => true do |t|
    t.string   "name",                           :null => false
    t.integer  "type_id"
    t.integer  "status_id",       :default => 1
    t.string   "permalink",                      :null => false
    t.integer  "resources_count", :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "organizations", ["permalink"], :name => "index_organizations_on_permalink", :unique => true
  add_index "organizations", ["type_id"], :name => "index_organizations_on_type_id"

  create_table "page_assets", :force => true do |t|
    t.integer  "page_id"
    t.integer  "asset_id"
    t.integer  "order"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "page_assets", ["asset_id"], :name => "index_page_assets_on_asset_id"
  add_index "page_assets", ["page_id"], :name => "index_page_assets_on_page_id"

  create_table "page_faqs", :force => true do |t|
    t.integer  "page_id"
    t.integer  "faq_id"
    t.integer  "order"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "page_faqs", ["faq_id"], :name => "index_page_faqs_on_faq_id"
  add_index "page_faqs", ["page_id"], :name => "index_page_faqs_on_page_id"

  create_table "page_resources", :force => true do |t|
    t.integer  "page_id"
    t.integer  "resource_id"
    t.integer  "order"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "page_resources", ["page_id"], :name => "index_page_resources_on_page_id"
  add_index "page_resources", ["resource_id"], :name => "index_page_resources_on_resource_id"

  create_table "pages", :force => true do |t|
    t.integer  "status_id",          :default => 1
    t.integer  "page_type_id",       :default => 1
    t.integer  "order",              :default => 0
    t.boolean  "locked",             :default => false
    t.boolean  "in_main_nav",        :default => false
    t.boolean  "in_sub_nav",         :default => false
    t.string   "title",                                                   :null => false
    t.string   "short_title",        :default => ""
    t.string   "permalink",                                               :null => false
    t.string   "absolute_url",                                            :null => false
    t.string   "redirect",           :default => ""
    t.text     "copy",               :default => ""
    t.text     "meta_description",   :default => ""
    t.text     "teaser",             :default => ""
    t.string   "resources_title",    :default => "Recommended Resources"
    t.string   "resources_subtitle", :default => ""
    t.integer  "ancestry_depth",     :default => 0
    t.string   "ancestry"
    t.integer  "gallery_id"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
  end

  add_index "pages", ["absolute_url"], :name => "index_pages_on_absolute_url", :unique => true
  add_index "pages", ["ancestry"], :name => "index_pages_on_ancestry"
  add_index "pages", ["gallery_id"], :name => "index_pages_on_gallery_id"
  add_index "pages", ["permalink"], :name => "index_pages_on_permalink"
  add_index "pages", ["status_id"], :name => "index_pages_on_status_id"

  create_table "phases", :force => true do |t|
    t.string   "name",                       :null => false
    t.integer  "order",      :default => 0
    t.text     "teaser",     :default => ""
    t.integer  "page_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "phases", ["page_id"], :name => "index_phases_on_page_id"

  create_table "ppcs", :force => true do |t|
    t.string   "title"
    t.string   "body"
    t.string   "permalink"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "ppcs", ["permalink"], :name => "index_ppcs_on_permalink", :unique => true

  create_table "promo_connections", :force => true do |t|
    t.integer  "order",             :default => 0
    t.integer  "promo_instance_id"
    t.integer  "promoable_id"
    t.string   "promoable_type"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "promo_connections", ["promo_instance_id"], :name => "index_promo_connections_on_promo_instance_id"
  add_index "promo_connections", ["promoable_id", "promoable_type"], :name => "index_promo_connections_on_promoable_id_and_promoable_type"

  create_table "promo_instances", :force => true do |t|
    t.boolean  "is_locked",      :default => false
    t.string   "title",                             :null => false
    t.string   "link",           :default => ""
    t.text     "copy",           :default => ""
    t.datetime "publish_date"
    t.datetime "unpublish_date"
    t.integer  "promo_id"
    t.integer  "page_id"
    t.string   "image_uid"
    t.string   "image_name"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "misc_text"
    t.string   "color",          :default => ""
    t.string   "rollover_uid"
    t.string   "rollover_name"
  end

  add_index "promo_instances", ["page_id"], :name => "index_promo_instances_on_page_id"
  add_index "promo_instances", ["promo_id"], :name => "index_promo_instances_on_promo_id"

  create_table "promos", :force => true do |t|
    t.boolean  "is_locked",  :default => true
    t.boolean  "is_image",   :default => false
    t.string   "title",                         :null => false
    t.string   "control",                       :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "public_folder_connections", :force => true do |t|
    t.integer  "folder_id"
    t.integer  "site_setting_id"
    t.integer  "order"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "public_folder_connections", ["folder_id"], :name => "index_public_folder_connections_on_folder_id"

  create_table "questions", :force => true do |t|
    t.integer  "user_id",                                    :null => false
    t.integer  "adviser_id"
    t.text     "question"
    t.boolean  "answered",                :default => false
    t.boolean  "accepts_tos",             :default => true
    t.boolean  "new_comment_for_user",    :default => false
    t.boolean  "new_for_adviser",         :default => false
    t.boolean  "new_comment_for_adviser", :default => false
    t.datetime "last_commented_at"
    t.integer  "last_commenter_id"
    t.integer  "comments_count",          :default => 0
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "questions", ["adviser_id"], :name => "index_questions_on_adviser_id"
  add_index "questions", ["last_commenter_id"], :name => "index_questions_on_last_commenter_id"
  add_index "questions", ["user_id"], :name => "index_questions_on_user_id"

  create_table "quick_links", :force => true do |t|
    t.string   "text"
    t.string   "destination"
    t.integer  "order"
    t.integer  "site_setting_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "referral_codes", :force => true do |t|
    t.integer  "contest_id", :null => false
    t.integer  "user_id",    :null => false
    t.string   "code",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "referral_codes", ["code"], :name => "index_referral_codes_on_code", :unique => true
  add_index "referral_codes", ["contest_id", "user_id"], :name => "index_referral_codes_on_contest_id_and_user_id", :unique => true

  create_table "referral_emails", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "recipient",  :null => false
    t.string   "subject",    :null => false
    t.text     "message"
    t.boolean  "cc_me"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "referral_emails", ["user_id"], :name => "index_referral_emails_on_user_id"

  create_table "referrals", :force => true do |t|
    t.integer  "referrer_id", :null => false
    t.integer  "referred_id", :null => false
    t.integer  "contest_id",  :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "referrals", ["referrer_id", "referred_id"], :name => "index_referrals_on_referrer_id_and_referred_id", :unique => true

  create_table "resource_assets", :force => true do |t|
    t.integer  "resource_id"
    t.integer  "asset_id"
    t.integer  "order"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "resource_assets", ["asset_id"], :name => "index_resource_assets_on_asset_id"
  add_index "resource_assets", ["resource_id"], :name => "index_resource_assets_on_resource_id"

  create_table "resource_audiences", :force => true do |t|
    t.integer  "resource_id", :null => false
    t.integer  "audience_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "resource_audiences", ["audience_id"], :name => "index_resource_audiences_on_audience_id"
  add_index "resource_audiences", ["resource_id"], :name => "index_resource_audiences_on_resource_id"

  create_table "resource_boroughs", :force => true do |t|
    t.integer  "resource_id"
    t.integer  "borough_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "resource_boroughs", ["borough_id"], :name => "index_resource_boroughs_on_borough_id"
  add_index "resource_boroughs", ["resource_id"], :name => "index_resource_boroughs_on_resource_id"

  create_table "resource_imports", :force => true do |t|
    t.string   "attachment_uid"
    t.string   "attachment_name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "resource_languages", :force => true do |t|
    t.integer  "resource_id", :null => false
    t.integer  "language_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "resource_languages", ["language_id"], :name => "index_resource_languages_on_language_id"
  add_index "resource_languages", ["resource_id"], :name => "index_resource_languages_on_resource_id"

  create_table "resource_phases", :force => true do |t|
    t.integer  "resource_id", :null => false
    t.integer  "phase_id",    :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "resource_phases", ["phase_id"], :name => "index_resource_phases_on_phase_id"
  add_index "resource_phases", ["resource_id"], :name => "index_resource_phases_on_resource_id"

  create_table "resource_subjects", :force => true do |t|
    t.integer  "resource_id"
    t.integer  "subject_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "resource_subjects", ["resource_id"], :name => "index_resource_subjects_on_resource_id"
  add_index "resource_subjects", ["subject_id"], :name => "index_resource_subjects_on_subject_id"

  create_table "resource_subway_lines", :force => true do |t|
    t.integer  "resource_id",    :null => false
    t.integer  "subway_line_id", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "resource_subway_lines", ["resource_id"], :name => "index_resource_subway_lines_on_resource_id"
  add_index "resource_subway_lines", ["subway_line_id"], :name => "index_resource_subway_lines_on_subway_line_id"

  create_table "resource_suggestions", :force => true do |t|
    t.integer  "user_id",                            :null => false
    t.integer  "type_id"
    t.string   "attachment_uid"
    t.string   "attachment_name"
    t.string   "link"
    t.string   "title"
    t.text     "description"
    t.boolean  "accepts_tos"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "was_used",        :default => false
  end

  add_index "resource_suggestions", ["type_id"], :name => "index_resource_suggestions_on_type_id"
  add_index "resource_suggestions", ["user_id"], :name => "index_resource_suggestions_on_user_id"

  create_table "resource_supports", :force => true do |t|
    t.integer  "resource_id"
    t.integer  "support_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "resource_supports", ["resource_id"], :name => "index_resource_supports_on_resource_id"
  add_index "resource_supports", ["support_id"], :name => "index_resource_supports_on_support_id"

  create_table "resources", :force => true do |t|
    t.string   "name",                                   :null => false
    t.integer  "type_id",                                :null => false
    t.integer  "bookmarks_count",      :default => 0
    t.integer  "helpful_count",        :default => 1
    t.integer  "organization_id"
    t.string   "website"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "contact_phone_number"
    t.string   "street"
    t.string   "city"
    t.string   "state",                :default => "NY"
    t.string   "postal_code"
    t.text     "when_text"
    t.string   "cost_text"
    t.string   "size_text"
    t.boolean  "is_experts_pick"
    t.integer  "conditions_of_use_id"
    t.text     "body"
    t.text     "teaser",               :default => ""
    t.string   "logo_uid"
    t.string   "logo_name"
    t.string   "attachment_label"
    t.integer  "status_id",            :default => 1
    t.string   "permalink",                              :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "last_commented_at"
    t.integer  "last_commenter_id"
    t.integer  "comments_count",       :default => 0
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "last_editor_id"
    t.text     "keywords",             :default => ""
  end

  add_index "resources", ["conditions_of_use_id"], :name => "index_resources_on_conditions_of_use_id"
  add_index "resources", ["last_commenter_id"], :name => "index_resources_on_last_commenter_id"
  add_index "resources", ["last_editor_id"], :name => "index_resources_on_last_editor_id"
  add_index "resources", ["organization_id"], :name => "index_resources_on_organization_id"
  add_index "resources", ["permalink"], :name => "index_resources_on_permalink", :unique => true
  add_index "resources", ["status_id"], :name => "index_resources_on_status_id"
  add_index "resources", ["type_id"], :name => "index_resources_on_type_id"

  create_table "scholarship_audiences", :force => true do |t|
    t.integer  "scholarship_id", :null => false
    t.integer  "audience_id",    :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "scholarship_audiences", ["audience_id"], :name => "index_scholarship_audiences_on_audience_id"
  add_index "scholarship_audiences", ["scholarship_id"], :name => "index_scholarship_audiences_on_scholarship_id"

  create_table "scholarship_submissions", :force => true do |t|
    t.string   "first_name",                  :default => "",    :null => false
    t.string   "last_name",                   :default => "",    :null => false
    t.string   "high_school",                 :default => "",    :null => false
    t.string   "year_in_school",              :default => "",    :null => false
    t.string   "email",                       :default => "",    :null => false
    t.string   "phone",                       :default => "",    :null => false
    t.string   "state",                       :default => "",    :null => false
    t.string   "birth_month",                 :default => "",    :null => false
    t.string   "birth_year",                  :default => "",    :null => false
    t.boolean  "not_currently_enrolled"
    t.boolean  "of_age_or_consent"
    t.string   "document_uid"
    t.string   "document_name"
    t.string   "video_url",                   :default => ""
    t.text     "description"
    t.boolean  "agree_to_terms"
    t.integer  "scholarship_id",                                 :null => false
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.text     "submission_format",           :default => ""
    t.text     "submission_prompt",           :default => ""
    t.text     "video_embed"
    t.string   "thumbnail_uid"
    t.string   "thumbnail_name"
    t.boolean  "selected_entry",              :default => false
    t.integer  "user_submission_votes_count", :default => 0
    t.integer  "school_type_id",              :default => 0
    t.string   "title"
    t.integer  "order",                       :default => 0
  end

  add_index "scholarship_submissions", ["scholarship_id"], :name => "index_scholarship_submissions_on_scholarship_id"

  create_table "scholarships", :force => true do |t|
    t.string   "name",                     :default => "",                    :null => false
    t.integer  "status_id",                :default => 1,                     :null => false
    t.datetime "end_date",                                                    :null => false
    t.text     "copy",                     :default => ""
    t.text     "terms",                    :default => ""
    t.text     "meta_description"
    t.string   "permalink",                                                   :null => false
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.text     "submission_format",        :default => ""
    t.text     "submission_prompt",        :default => ""
    t.text     "thank_you",                :default => ""
    t.datetime "voting_start_date"
    t.datetime "voting_end_date"
    t.string   "voting_title",             :default => "Vote for the winner"
    t.text     "voting_copy"
    t.string   "high_school_label"
    t.string   "or_label_text"
    t.string   "description_instructions"
    t.string   "title_label"
    t.boolean  "show_upload",              :default => true
    t.boolean  "show_video_url",           :default => true
    t.boolean  "show_or_label",            :default => true
    t.boolean  "show_title",               :default => true
    t.boolean  "require_authentication",   :default => false
    t.text     "logged_in_copy"
  end

  add_index "scholarships", ["permalink"], :name => "index_scholarships_on_permalink"

  create_table "site_settings", :force => true do |t|
    t.string "mc_api_key"
  end

  create_table "subjects", :force => true do |t|
    t.string   "name",                      :null => false
    t.integer  "order",      :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "subway_lines", :force => true do |t|
    t.string   "name",                      :null => false
    t.integer  "order",      :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "supports", :force => true do |t|
    t.string   "name",                      :null => false
    t.integer  "order",      :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "system_avatars", :force => true do |t|
    t.string   "name",                      :null => false
    t.string   "image_uid",                 :null => false
    t.string   "image_name",                :null => false
    t.integer  "order",      :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_audiences", :force => true do |t|
    t.integer  "user_id"
    t.integer  "audience_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "user_text"
  end

  add_index "user_audiences", ["audience_id"], :name => "index_user_audiences_on_audience_id"
  add_index "user_audiences", ["user_id"], :name => "index_user_audiences_on_user_id"

  create_table "user_newsletters", :force => true do |t|
    t.integer  "user_id"
    t.integer  "newsletter_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "user_newsletters", ["newsletter_id"], :name => "index_user_newsletters_on_newsletter_id"
  add_index "user_newsletters", ["user_id"], :name => "index_user_newsletters_on_user_id"

  create_table "user_resources", :force => true do |t|
    t.integer  "user_id"
    t.integer  "resource_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_resources", ["resource_id"], :name => "index_user_resources_on_resource_id"
  add_index "user_resources", ["user_id"], :name => "index_user_resources_on_user_id"

  create_table "user_settings", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "notify_folder_update"
    t.boolean  "notify_thread_comments"
    t.boolean  "notify_resource_comments"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.boolean  "notify_question_assignments", :default => false
    t.boolean  "notify_blog_comments"
  end

  add_index "user_settings", ["user_id"], :name => "index_user_settings_on_user_id"

  create_table "user_submission_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "scholarship_submission_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "user_submission_votes", ["scholarship_submission_id"], :name => "index_user_submission_votes_on_scholarship_submission_id"
  add_index "user_submission_votes", ["user_id"], :name => "index_user_submission_votes_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "username",               :default => "",    :null => false
    t.integer  "status_id",              :default => 2
    t.integer  "role_id",                :default => 1,     :null => false
    t.string   "custom_avatar_uid"
    t.string   "custom_avatar_name"
    t.boolean  "is_adviser",             :default => false
    t.boolean  "accepts_tos",            :default => true
    t.boolean  "set_up_profile",         :default => false
    t.integer  "verified_type_id",       :default => 0
    t.integer  "system_avatar_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "borough_id"
    t.string   "zipcode"
    t.text     "bio"
    t.boolean  "from_guest_user"
  end

  add_index "users", ["borough_id"], :name => "index_users_on_borough_id"
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["role_id"], :name => "index_users_on_role_id"
  add_index "users", ["system_avatar_id"], :name => "index_users_on_system_avatar_id"
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
