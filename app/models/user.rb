# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string(255)
#  salt             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  name             :string(255)
#  choice_1         :integer
#  choice_2         :integer
#  choice_3         :integer
#  choice_4         :integer
#  choice_5         :integer
#  choice_6         :integer
#  choice_7         :integer
#  choice_8         :integer
#  choice_9         :integer
#  choice_10        :integer
#  email_sent       :boolean          default(FALSE)
#  match_email_sent :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email
  
  after_create :set_salt
  
  def set_salt
    self.salt = SecureRandom.hex(8)
    self.save
  end
  
  def email=(email_s)
    self[:email] = email_s.split("@")[0]
  end
  
  def to_s
    self.name
  end
  
  def choices
    c_list = []
    (1..10).each {|n|
      choice = self.try("choice_#{n}")
      next unless choice.present?
      c_list << choice
    }
    return c_list.uniq.delete_if{|x| x == 0}
  end
  
  def matches
    matches = []
    self.choices.each do |c|
      u = User.find(c)
      next unless u.present?
      matches << u if u.choices.include?(self.id)
    end
    matches
  end
end
