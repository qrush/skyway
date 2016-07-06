# https://github.com/thoughtbot/high_voltage#override
class PagesController < ApplicationController
  include HighVoltage::StaticPage

  layout :layout_for_page

  private

  def layout_for_page
    case params[:id]
    when 'sampler'
      'sampler'
    else
      'application'
    end
  end
end
