# frozen_string_literal: true

admin = User.create(email: 'admin@freaksidea.com', password: '123456', permissions: %w[view add modify delete])
blogger = User.create(email: 'member@freaksidea.com', password: '123456', permissions: %w[view add])

2.times do
  Article.create(
    author_id: admin.id,
    title: Faker::Book.title,
    body: Faker::Lorem.sentence
  )
end

5.times do
  Article.create(
    author_id: blogger.id,
    title: Faker::Book.title,
    body: Faker::Lorem.sentence
  )
end
