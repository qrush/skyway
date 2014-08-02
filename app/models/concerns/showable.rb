module Showable
  extend ActiveSupport::Concern

  included do
    scope :by_name, -> { order("name asc") }

    validates_presence_of :name

    define_method "other_#{self.name.downcase}_id" do
      id
    end
  end

  def shows_percentage
    (shows.count / Show.before_today.count.to_f) * 100
  end

  def first_letter
    if name =~ /^[A-Z]/i
      name[0].upcase
    else
      "#"
    end
  end
end
