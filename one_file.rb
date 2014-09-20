require 'active_record'
require 'mysql2'
require 'faker'
# Log all the stuff
ActiveRecord::Base.logger = Logger.new(STDERR)

#TODO use env for port user db pass
ActiveRecord::Base.establish_connection(
    adapter: 'mysql2',
    database: 'test',
    username: 'root',
    password: '',
    host: '127.0.0.1',
    port: 3306
)

#LEVEL
ActiveRecord::Schema.define do
  create_table :levels do |table|
    table.column :title, :string
    table.column :description, :string
    table.column :points, :integer
  end

  create_table :lessons do |table|
    table.column :name, :string
    table.column :description, :string
    table.column :points, :integer
    table.column :status, :boolean
    table.column :level_id, :integer
  end

  create_table :questions do |table|
    table.column :title, :string
    table.column :response, :string
    table.column :points, :integer
    table.column :lesson_id, :integer
  end
end

class Level < ActiveRecord::Base
  has_many :lessons

  def to_s
    "#{title} -- #{description} -- #{points}"
  end
end

class Lesson < ActiveRecord::Base
  has_many :questions
  belongs_to :level
end

class Question < ActiveRecord::Base
  belongs_to :lesson
end


##CREATE levels
Level.delete_all
10.times do |t|
  Level.create!(
      title: Faker::Name.first_name,
      description: Faker::Lorem.sentence,
      points: t+1
  )
end

##CREATE lessons
Lesson.delete_all
10.times do |t|
  Lesson.create!(
     name: Faker::Name.last_name,
     description: Faker::Lorem.sentence,
     status: true,
     level_id: Level.find(rand(1..10))
  )
end

Question.delete_all
100.times do |t|
  Question.create!(
      title: Faker::Name.last_name,
      response: Faker::Name.first_name,
      points: rand(1..100),
      lesson_id: rand(1..10)
  )
end
