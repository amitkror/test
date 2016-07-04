# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :forum_thread do
    forum nil
    user nil
    name "Forum Thread"
    message "Porta rhoncus dis elementum purus hac. Habitasse rhoncus nunc "\
    "dolor, purus in a nisi? Magna, lorem! Adipiscing vel rhoncus elit "\
    "scelerisque vut in lectus? Cursus odio facilisis sit, rhoncus nunc "\
    "quis montes, aliquam pulvinar, sociis urna porta odio mid sed, placerat "\
    "cursus lundium odio. Porttitor ac dis eros enim porttitor non! Porttitor "\
    "eros nec adipiscing lectus, tincidunt, dictumst non in, adipiscing "\
    "porttitor, dictumst vel porta elit cursus nunc enim ut, tincidunt porta, "\
    "est turpis turpis cum augue augue magna etiam, est eu ut penatibus velit "\
    "platea magna est placerat porta, lacus cum. Platea elit phasellus purus. "\
    "Proin sit ac ut nascetur sagittis, proin ac! Pulvinar nunc ac tortor, "\
    "aenean, eros porttitor nunc! Tortor amet ultricies, magna sit pulvinar"
  end
end
