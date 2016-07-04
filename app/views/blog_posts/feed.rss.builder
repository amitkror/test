#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "NYC College Line"
    xml.author "NYC College Line"
    xml.description "NYC College Line Community, Scholarship, Events, Blog, Advisory And Forum Content, Search Program Directory"
    xml.link "http://nyccollegeline.org"
    xml.language "en"

    for article in @blog_posts
      xml.item do
        if article.title
          xml.title article.title
        else
          xml.title ""
        end
        xml.author article.user.username
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link "http://nyccollegeline.org/blog/" + article.permalink

        xml.guid article.id

        text = truncate(strip_tags(article.body), :length => 620).html_safe
        
        xml.description "<p>" + text + "</p>"

      end
    end
  end
end