# frozen_string_literal: true

admin = User.create(
  email: 'admin@freaksidea.com',
  password: '123456',
  permissions: %w[view add modify delete manage]
)

member = User.create(
  email: 'member@freaksidea.com',
  password: '123456',
  permissions: %w[view add modify delete]
)

2.times do
  Article.create(
    author_id: admin.id,
    title: Faker::Book.title,
    body: Faker::Lorem.sentence
  )
end

5.times do
  Article.create(
    author_id: member.id,
    title: Faker::Book.title,
    body: Faker::Lorem.sentence
  )
end
