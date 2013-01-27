namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)

    puts "Creating user ##{n} of 99...\r"
  end
end

def make_microposts
  users = User.all(limit: 6)
  50.times do |n|
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
    puts "Creating micropost ##{n} of 50...\r"
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  puts "Creating relationships...\r"
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
  puts "Creating relationships... done."
end