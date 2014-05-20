class Setlist < ActiveRecord::Base
  belongs_to :show
  has_many :slots, -> { order position: :asc }, dependent: :destroy
  has_many :songs, through: :slots

  def cache_key
    [super, *slots.map(&:cache_key)].join("-")
  end

  def without_notes
    [name, *slots.map(&:name)].join("\n")
  end

  def to_s(options = {})
    if options[:without_notes]
      "#{name}: #{slots.map { |slot| slot.to_s(options) }.join(' ')}"
    else
      [name, *slots.map { |slot| slot.to_s(options) }].join("\n")
    end
  end
end
