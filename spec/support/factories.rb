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