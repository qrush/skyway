class Article < ActiveRecord::Base
  validates_presence_of :title, :body, :published_at

  scope :undrafted, -> { where(draft: false) }
  scope :published, -> { order(published_at: :desc) }

  def to_html
    Kramdown::Document.new(body).to_html
  end

  def to_param
    "#{id}-#{title.downcase.gsub(" ", "-")}"
  end
end
