require 'open-uri'

namespace :students do
  desc "parse students and add to DB"
  task :update => :environment do
    open('http://www.colby.edu/personal/p/pagraham/out.csv').each_with_index do |line, i|
      line = line.strip
      email, name = line.split(",")
      u = User.new
      u.name = name
      u.email = email
      u.save
    end
  end
end