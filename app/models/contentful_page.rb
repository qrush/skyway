class ContentfulPage < ContentfulModel::Base
  extend ActiveSupport::Benchmarkable

  class << self
    delegate :logger, to: Rails

    def instance
      @instance ||= benchmark "Contentful #{self.class} Load" do
        find(Rails.application.secrets["contentful_#{self.class.name.downcase}"])
      end
    end
  end
end
