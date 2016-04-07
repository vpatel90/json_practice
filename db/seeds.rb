# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


10.times do
  User.create(name:Faker::Name.name)
end

20.times do
  Post.create(title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph(2), user_id: User.all.sample.id)
end

60.times do
  Comment.create(body: Faker::Hipster.sentence, user_id: User.all.sample.id, post_id: Post.all.sample.id)
end

200.times do
  Vote.create(user_id: User.all.sample.id, comment_id: Comment.all.sample.id)
end
