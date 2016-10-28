# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
#
User.delete_all
Post.delete_all

1..40.times do |i|
  user = User.create(lastname:  "Surname#{i}",
                     firstname: "Firstname#{i}",
                     username:  "Username#{i}",
                     password:  "password")

  Post.create( title: "Title#{i}",
              body: "Body#{i}",
              user: user)
end
