# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

users = [
  { name: "Alice" },
  { name: "Bob" },
  { name: "Charlie" },
  { name: "David" },
  { name: "Eve" },
  { name: "Frank" },
  { name: "Grace" },
  { name: "Hannah" },
  { name: "Ivy" },
  { name: "Jack" },
  { name: "Karen" },
  { name: "Leo" },
  { name: "Mona" },
  { name: "Nina" },
  { name: "Oscar" },
  { name: "Paul" },
  { name: "Quinn" },
  { name: "Rachel" },
  { name: "Sam" },
  { name: "Tina" },
  { name: "Uma" },
  { name: "Victor" },
  { name: "Wendy" },
  { name: "Xander" },
  { name: "Yara" },
  { name: "Zane" }
]

users.each do |user_attributes|
  User.find_or_create_by!(name: user_attributes[:name]) do |user|
    user.name = user_attributes[:name]
  end
end
