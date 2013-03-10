namespace :students do
  desc "parse students and add to DB"
  task :stats => :environment do
    choice_counts = {}
    User.where(:email_sent => true).each do |u|
      next unless u.choices.length > 0
      u.choices.each do |c|
        choice_counts[c] ||= 0
        choice_counts[c] += 1
      end
    end
    choice_counts.sort_by{|k,v| v}.reverse[0..30].each do |uid, count|
      puts "#{User.find(uid).name} (#{uid}): #{count}"
    end
  end
end
