# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# User
user_1 = User.create(email: "aya@example.com")
user_2 = User.create(email: "salman@example.com")
user_3 = User.create(email: "james@example.com")

# Shotened Url
short_url_1 = ShortenedUrl.create(
    :long_url => "http://aya.example.com",
    :short_url => "test",
    :user_id => user_1.id
)

short_url_2 = ShortenedUrl.create(
    :long_url => "http://salman.example.com",
    :short_url => "test",
    :user_id => user_2.id
)

short_url_3 = ShortenedUrl.create(
    :long_url => "http://james.example.com",
    :short_url => "test",
    :user_id => user_3.id
)

# Tag topic

tag_1 = TagTopic.create(tag_topic: "news")
tag_2 = TagTopic.create(tag_topic: "music")
tag_3 = TagTopic.create(tag_topic: "sports")