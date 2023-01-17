namespace :setup do
  desc "Added first data"
  task initial_data: :environment do
    # puts "*** Drop old database***"
    # Rake::Task["db:drop"].invoke

    puts "*** Do migrate ***"
    Rake::Task["db:migrate"].invoke

    puts "*** Add initial data ***"
    lines = File.readlines(Rails.root.join('lib', 'tasks', '001_initial_data.txt'), encoding: "UTF-8", chomp: true)

    # Пользователь 1
    user1 = User.new(
      name: lines[1],
      email: lines[2],
      password: lines[3],
      password_confirmation: lines[3]
    )
    user1.save

    # Пользователь 2
    user2 = User.new(
      name: lines[4],
      email: lines[5],
      password: lines[6],
      password_confirmation: lines[6]
    )
    user2.save

    # Мероприятие 1
    event = Event.new(
      title: lines[8],
      address: lines[9],
      description: lines[10],
      datetime: Time.now,
      user_id: user1.id
    )
    event.save

  end
end
