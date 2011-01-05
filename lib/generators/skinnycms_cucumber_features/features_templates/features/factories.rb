Factory.define :user do |user|
  user.name                  "Foobar"
  user.email                 "foo@bar.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.define :page do |page|
  page.title                 "foobar"
  page.header                "foobar"
  page.permalink             "foobar"
end

Factory.define :page_content do |page_content|
  page_content.location      "foobar"
  page_content.content       "foobar"
end

Factory.define :category do |category|
  category.name              "foobar"
end

Factory.define :category_item do |category_item|
  category_item.categorizable_type "page"
end

Factory.define :cache_tumblr_post do |cache_tumblr_post|
  cache_tumblr_post.title    "my_blog"
  cache_tumblr_post.desc     "my_blog_description"
end