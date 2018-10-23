require 'faker'
include Faker


#create Users
5.times do
   user = User.create!(
    user_name: Faker::Name.name,    
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
    )
  user.skip_confirmation!
  user.save!
  2.times do
    Wiki.create!(
        title:  Faker::Lorem.sentence,
        body:  Faker::Lorem.paragraph,
        user_id: user.id
    )
  end
  puts "#{Wiki.count} wikis created"
end

puts "5 users created"

# Create admin user
    admin = User.create!(
    user_name: Faker::Name.name,   

    email: 'jellyadmin@example.com',
    password: 'helloworld',
    role: 'admin')

  admin.skip_confirmation!
  admin.save!
puts "admin user created"

# Create standard user
2.times do
  User.create!(
  user_name: Faker::Name.name,    

  email: Faker::Internet.email,
  password: 'helloworld'
  )
end
puts "2 standard users created"


premium = User.create!(
   user_name: Faker::Name.name,    

  email: 'premium@example.com',
  password: 'password',
  confirmed_at: Time.now,
  role: 'premium'
)
puts "1 premium users created"

