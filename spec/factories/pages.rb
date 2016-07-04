# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence(:lorem_ipsum) {|n| "<p>Auctor pellentesque magna tortor porta in amet
    cum adipiscing, lorem. Montes ridiculus? Turpis turpis, lorem dolor
    phasellusmassa, dignissim cras! Turpis enim dis mauris massa dignissim.
    Risus mid, proin adipiscing nec sit magnis vel natoque? Ac lectus etiam
    tortor adipiscing? Tristique hac mus placerat facilisis. Adipiscing vel
    facilisis, tincidunt cum porttitor, nec auctor, purus ac porta. Dis amet
    magna, etiam. Phasellus placerat? A, placerat elit ut, et magna urna ut
    nascetur rhoncus, sociis aenean mattis eu odio, et nec non. Pulvinar. Ut
    tristique rhoncus, risus pulvinar tincidunt tincidunt nascetur turpis vel
    urna placerat aliquet massa, ultricies, ultrices natoque, tempor, porttitor
    magna non? Enim velit tortor, hac, elementum porttitor. Dolor ac
    pellentesque in, ut ridiculus? Turpis? Et? Elementum ac nunc! Vel.</p><p>Et
    cras mauris mattis turpis pid eros? Placerat integer. Ut proin. Nisi sed vel
    lundium nisi scelerisque sed quis? A elit elementum scelerisque, non
    tincidunt ut aliquet mauris habitasse augue nisi? Magna parturient, amet!
    Dignissim, cursus a. Dignissim mauris, urna proin nunc lundium scelerisque
    massa arcu sit facilisis etiam sed augue ut diam proin duis! Rhoncus elit
    diam sit, velit porttitor vel enim? Mattis cum, hac, aenean pulvinar. Sit
    sed adipiscing? Tristique parturient! Proin cursus et vel sit lectus, sed
    adipiscing cursus et proin porttitor diam, eu turpis, et? Duis porttitor.
    A ultrices odio mid? Velit, dignissim adipiscing integer amet lectus, turpi
    elementum hac. Risus vel turpis lorem pellentesque! Et lacus pulvinar!
    Sociis! Eu vel lundium pulvinar! Et ut.</p>" }

  sequence(:page_title) {|n| "Page title #{n}" }

  sequence(:page_sub_title) {|n| "Page sub title #{n}" }

  factory :page do
    status_id Page::STATUSES[:Published]
    title { generate(:page_title) }
    short_title ''
    copy { generate(:lorem_ipsum) }
    teaser "Duis porttitor. A ultrices odio mid? Velit, dignissim adipiscing
    integer amet lectus, turpi elementum hac. Risus vel turpis lorem
    pellentesque! Et lacus pulvinar! Sociis! Eu vel lundium pulvinar! Et ut."
    permalink ''
    locked true
    parent_id nil
    order 0
    in_main_nav false
    in_sub_nav false
    page_type_id 1
  end
end
