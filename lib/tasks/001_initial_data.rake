namespace :setup do
  desc "Added first data"
  task initial_data: :environment do
    # puts "*** Drop old database***"
    # Rake::Task["db:drop"].invoke

    puts "*** Do migrate ***"
    Rake::Task["db:migrate"].invoke

    puts "*** Add initial data ***"
    lines = File.readlines("#{__dir__}/001_initial_data.txt", encoding: "UTF-8", chomp: true)

    # Пользователь 1
    user1 = User.new(
      name: lines[1],
      email: lines[2],
      password: lines[3],
      password_confirmation: lines[3]
    )

    user1.save

  end
end
