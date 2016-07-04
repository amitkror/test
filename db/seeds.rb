# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the
# db with db:setup).
#

#unless Rails.env.production?
  puts "-----------------------------------------------------------------------"
  puts " Seeding the database"
  puts "-----------------------------------------------------------------------"

  #require 'factory_girl'

  # FactoryGirl.find_definitions

  FactoryGirl.create(:system_avatar, name: "Default", order: 1)
  FactoryGirl.create(:system_avatar, name: "Screen", order: 2)
  FactoryGirl.create(:system_avatar, name: "Light bulb", order: 3)
  FactoryGirl.create(:system_avatar, name: "Pencil", order: 4)
  FactoryGirl.create(:system_avatar, name: "Book", order: 5)

  u = FactoryGirl.build(:user, email: "grad-nyc.team@blenderbox.com",
    password: "-Bagel is the bomb!", username: "admin")
  u.skip_confirmation!
  u.save

  u = FactoryGirl.build(:user, email: "cbrown@blenderbox.com", role_id: 1,
    password: "qwerty123!", username: "kayluhb")
  u.skip_confirmation!
  u.save
  puts "created #{u.email}"

  p = FactoryGirl.create(:page, title: "Explore", in_main_nav: true, order: 1,
    page_type_id: 2,
    copy: '<p class="subhead">Auctor pellentesque magna tortor porta in amet
    cum adipiscing, lorem. Montes ridiculus? Turpis turpis, lorem dolor
    phasellusmassa, dignissim cras! Turpis enim dis mauris massa dignissim.
    Risus mid, proin adipiscing nec sit <a href="http://foo.com">magnis vel
    natoque</a>?</p><p><iframe width="672" height="378" frameborder="0"
    src="http://www.youtube.com/embed/_L0xl7s4wAg"
    allowfullscreen=""></iframe></p><p class="caption">Ac lectus etiam tortor
    adipiscing? Tristique hac mus placerat facilisis.</p>')
  FactoryGirl.create(:page, title: "FAFSA + Pay", locked: false, order: 3,
    parent: p, page_type_id: 2)
  FactoryGirl.create(:page, title: "Apply + TAP", locked: false, order: 3,
    parent: p, page_type_id: 2)
  FactoryGirl.create(:page, title: "Apply", in_main_nav: true, order: 2,
    page_type_id: 2)
  p = FactoryGirl.create(:page, title: "Pay For College", in_main_nav: true,
    order: 3, page_type_id: 2)
  FactoryGirl.create(:page, title: "Getting Started", locked: false, order: 3,
    parent: p, page_type_id: 2)
  FactoryGirl.create(:page, title: "FAFSA + TAP", locked: false, order: 3,
    parent: p, page_type_id: 2)
  FactoryGirl.create(:page, title: "Loans", locked: false, order: 3, parent: p,
    page_type_id: 2)
  FactoryGirl.create(:page, title: "Scholarships", locked: false, order: 3,
    parent: p, page_type_id: 2)
  FactoryGirl.create(:page, title: "Search Money Matters resources",
    locked: false, order: 3, parent: p, page_type_id: 2)

  FactoryGirl.create(:page, title: "Use Your Summer", in_main_nav: true,
    order: 4, page_type_id: 2)
  FactoryGirl.create(:page, title: "Succeed in College", in_main_nav: true,
    order: 5, page_type_id: 2)

  FactoryGirl.create(:page, title: "About", in_sub_nav: true, locked: false,
    order: 100)
  FactoryGirl.create(:page, title: "Ask an Adviser", in_sub_nav: true,
    order: 101)
  FactoryGirl.create(:page, title: "Forum", in_sub_nav: true, order: 102,
    permalink: "forums", copy:"")
  FactoryGirl.create(:page, title: "Events", in_sub_nav: true, order: 103)
  FactoryGirl.create(:page, title: "FAQ", in_sub_nav: true, order: 104)
  FactoryGirl.create(:page, title: "Help", in_sub_nav: true, order: 105)
  FactoryGirl.create(:page, title: "Organizations", order: 106)

  p = FactoryGirl.create(:page, title: "Registrations", order: 107)
  FactoryGirl.create(:page, title: "Success!", order: 108, parent: p,
    status_id: 2,
    copy: "<p>Your account has been created and, and you can start saving
    resources, posting comments, and more.</p><p>We've also sent you an email
    with a confirmation link. Check your email and click the link to complete
    the sign-up.  If you don't see your email in 5 minutes, let us know at
    <a href=\"mailto:info@nyccollegeline.com\">info@nyccollegeline.com</a>.")

  FactoryGirl.create(:page, title: "Glossary", order: 200,
    copy: "<p>Too many acronyms and touch words around college? We hear you!
    <br/>Here are some definitions written by our experts.</p>")
  FactoryGirl.create(:page, title: "Terms of Use", order: 201)
  FactoryGirl.create(:page, title: "Privacy Policy", order: 203)
  FactoryGirl.create(:page, title: "Contact Us", order: 204)
  FactoryGirl.create(:page, title: "Search", order: 205)

  p = FactoryGirl.create(:page, title: "Languages", order:300)
  FactoryGirl.create(:page, title: "Bengali", locked:false, order:301,
   parent: p)
  FactoryGirl.create(:page, title: "Espanol", locked:false, order:302,
   parent: p)
  FactoryGirl.create(:page, title: "Francais", locked:false, order:303,
   parent: p)
  FactoryGirl.create(:page, title: "Haitian-creole", locked:false, order:304,
   parent: p)
  FactoryGirl.create(:page, title: "Urdu", locked:false, order:305,
   parent: p)
  FactoryGirl.create(:page, title: "Russian", locked:false, order:306,
   parent: p)
  FactoryGirl.create(:page, title: "Arabic", locked:false, order:307,
   parent: p)
  FactoryGirl.create(:page, title: "Korean", locked:false, order:308,
   parent: p)
  FactoryGirl.create(:page, title: "Japanese", locked:false, order:309,
   parent: p)
  puts "Added pages."

  # "Español"
  # "Français")
  # "اردو"
  # "русский"
  # "العربيّة"
  # "방문"
  # "ご案内"

  # Promos - the order here is important
  FactoryGirl.create(:promo, title: "Image", control: "image", is_image: true,
    is_locked: false)
  FactoryGirl.create(:promo, title: "Image and Text", control: "image_text",
    is_locked: false)
  FactoryGirl.create(:promo, title: "HTML", control: "html", is_locked: false)
  FactoryGirl.create(:promo, title: "Plain Text", control: "plain_text",
    is_locked: false)
  FactoryGirl.create(:promo, title: "Tweet", control: "tweet",
    is_locked: false)
  promo = FactoryGirl.create(:promo, title: "Search", control: "search",
    is_locked: false)
  promo = FactoryGirl.create(:promo, title: "Featured Comment",
    control: "featured_comment", is_locked: false)

  # All Our special non-editable promos
  promo = FactoryGirl.create(:promo, title: "Recent Posts",
    control: "recent_posts", is_locked: true)
  FactoryGirl.create(:promo_instance, title: promo.title, promo: promo)

  promo = FactoryGirl.create(:promo, title: "Top Resources",
    control: "top_resources", is_locked: true)
  FactoryGirl.create(:promo_instance, title: promo.title, promo: promo)

  promo = FactoryGirl.create(:promo, title: "Search Resources",
    control: "search_resources", is_locked: true)
  FactoryGirl.create(:promo_instance, title: promo.title, promo: promo)

  promo = FactoryGirl.create(:promo, title: "Why Register",
    control: "why_register", is_locked: true)
  FactoryGirl.create(:promo_instance, title: promo.title, promo: promo)
  puts "Added promos."

  FactoryGirl.create(:audience, name: "adviser", name_plural: "advisers",
    order:1)
  FactoryGirl.create(:audience, name: "college student",
    name_plural: "college students", order:2)
  FactoryGirl.create(:audience, name: "GED student",
    name_plural: "GED students", order: 3)
  FactoryGirl.create(:audience, name: "high school student",
    name_plural: "high school students", order:4)
  FactoryGirl.create(:audience, name: "parent or guardian",
    name_plural: "parent or guardians", order:5)
  FactoryGirl.create(:audience, name: "first-generation college student",
    name_plural: "first-generation college students",
    show_in_settings: false, order:6)
  FactoryGirl.create(:audience, name: "immigrant or child of immigrant",
    name_plural: "immigrants or children of immigrants",
    show_in_settings: false, order:7)
  FactoryGirl.create(:audience, name: "student with disability",
    name_plural: "students with disabilities",
    show_in_settings: false, order:8)
  FactoryGirl.create(:audience, name: "youth in foster care",
    name_plural: "youths in foster care",
    show_in_settings: false, order:9)
  FactoryGirl.create(:audience, name: "other", name_plural: "other", order:10)
  puts "Added audiences."

  FactoryGirl.create(:borough, name: "Bronx")
  FactoryGirl.create(:borough, name: "Brooklyn")
  FactoryGirl.create(:borough, name: "Manhattan")
  FactoryGirl.create(:borough, name: "Queens")
  FactoryGirl.create(:borough, name: "Staten Island")
  puts "Added boroughs."

  FactoryGirl.create(:conditions_of_use, title: "No Strings Attached",
    copy: "No restrictions on your remixing, redistributing, or making "\
          "derivative works. Give credit to the author, as required.")
  FactoryGirl.create(:conditions_of_use, title: "Remix and Share",
    copy: "Your remixing, redistributing, or making derivatives works comes "\
          "with some restrictions, including how it is shared.")
  FactoryGirl.create(:conditions_of_use, title: "Share Only",
    copy: "Your redistributing comes with some restrictions. Do not remix or "\
          "make derivative works.")
  FactoryGirl.create(:conditions_of_use, title: "Read the Fine Print",
    copy: "Copyrighted materials, available under Fair Use and the TEACH "\
          "Act for U.S.-based educators, or other custom arrangements. Go "\
          "to the resource provider to see their individual restrictions.")

  #FactoryGirl.create(:language, name: "English")
  FactoryGirl.create(:language, name: "Arabic")
  FactoryGirl.create(:language, name: "Bengali")
  FactoryGirl.create(:language, name: "Chinese")
  FactoryGirl.create(:language, name: "French")
  FactoryGirl.create(:language, name: "Haitian-Creole")
  FactoryGirl.create(:language, name: "Korean")
  FactoryGirl.create(:language, name: "Russian")
  FactoryGirl.create(:language, name: "Spanish")
  FactoryGirl.create(:language, name: "Urdu")
  FactoryGirl.create(:language, name: "Other")
  puts "Added languages."

  FactoryGirl.create(:newsletter, name: "High School Students")
  FactoryGirl.create(:newsletter, name: "College Students")
  FactoryGirl.create(:newsletter, name: "Parents")
  FactoryGirl.create(:newsletter, name: "Professionals/Advisors")
  FactoryGirl.create(:newsletter, name: "CUNY Updates")
  FactoryGirl.create(:newsletter, name: "Financial Aid Deadlines or Changes")
  puts "Added newsletters."

  FactoryGirl.create(:phase, name: "Explore")
  FactoryGirl.create(:phase, name: "Apply")
  FactoryGirl.create(:phase, name: "Pay For College")
  FactoryGirl.create(:phase, name: "Use Your Summer")
  FactoryGirl.create(:phase, name: "Succeed In College")
  puts "Added phases."

  FactoryGirl.create(:subject, name: "academic tutoring and classes")
  FactoryGirl.create(:subject, name: "career exploration")
  FactoryGirl.create(:subject, name: "college advising")
  FactoryGirl.create(:subject, name: "college search")
  FactoryGirl.create(:subject, name: "college application")
  FactoryGirl.create(:subject, name: "financial aid and planning")
  FactoryGirl.create(:subject, name: "internships and jobs")
  FactoryGirl.create(:subject, name: "life after college")
  FactoryGirl.create(:subject, name: "life in college")
  FactoryGirl.create(:subject, name: "professional development")
  FactoryGirl.create(:subject, name: "staying in college")
  FactoryGirl.create(:subject, name: "other")
  puts "Added subjects."

  FactoryGirl.create(:support, name: "cash stipend")
  FactoryGirl.create(:support, name: "computer lending")
  FactoryGirl.create(:support, name: "financial aid (application and test "\
    "fees)")
  FactoryGirl.create(:support, name: "financial aid (textbooks)")
  FactoryGirl.create(:support, name: "food")
  FactoryGirl.create(:support, name: "Metrocards")
  FactoryGirl.create(:support, name: "scholarships")
  puts "Added support."

  FactoryGirl.create(:subway_line, name: "1")
  FactoryGirl.create(:subway_line, name: "2")
  FactoryGirl.create(:subway_line, name: "3")
  FactoryGirl.create(:subway_line, name: "4")
  FactoryGirl.create(:subway_line, name: "5")
  FactoryGirl.create(:subway_line, name: "6")
  FactoryGirl.create(:subway_line, name: "7")
  FactoryGirl.create(:subway_line, name: "A")
  FactoryGirl.create(:subway_line, name: "C")
  FactoryGirl.create(:subway_line, name: "E")
  FactoryGirl.create(:subway_line, name: "B")
  FactoryGirl.create(:subway_line, name: "D")
  FactoryGirl.create(:subway_line, name: "F")
  FactoryGirl.create(:subway_line, name: "G")
  FactoryGirl.create(:subway_line, name: "J")
  FactoryGirl.create(:subway_line, name: "M")
  FactoryGirl.create(:subway_line, name: "Z")
  FactoryGirl.create(:subway_line, name: "L")
  FactoryGirl.create(:subway_line, name: "N")
  FactoryGirl.create(:subway_line, name: "Q")
  FactoryGirl.create(:subway_line, name: "R")
  puts "Added subways."

  f = FactoryGirl.create(:forum, name:"Exploration", order:1)
  FactoryGirl.create(:forum, name:"Getting In", order:2)
  FactoryGirl.create(:forum, name:"Money Matters", order:3)
  FactoryGirl.create(:forum, name:"Summer Matters", order:4)
  FactoryGirl.create(:forum, name:"College Success", order:5)
  puts "Added forums."

  FactoryGirl.create_list(:event, 10)
  puts "Added events"

#end
