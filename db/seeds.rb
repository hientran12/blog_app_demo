User.create!(name:  "Hien Tran",
             email: "hientv@example.com",
             password:              "1234567",
             password_confirmation: "1234567",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
50.times do
  title = Faker::Lorem.sentence
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.entries.create!(title: title,content: content) }
end

user = User.first
comment_user = User.last
entry = user.entries.first
50.times do
  comment = Faker::Lorem.sentence(2)
  Comment.create!(
             content: comment,
             user: comment_user,
             entry: entry
  )
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
