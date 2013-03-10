namespace :students do
  desc "parse students and add to DB"
  task :match => :environment do
    User.where(:email_sent => true, :match_email_sent => false).each do |u|
      next unless u.matches.length > 0
      puts "------", "#{u.name}:", u.matches.to_sentence
      UserMailer.match_email(u, u.matches).deliver
      u.update_attributes(:match_email_sent => true)
    end
  end
end
