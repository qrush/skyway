# https://github.com/thoughtbot/high_voltage#override
class PagesController < ApplicationController
  include HighVoltage::StaticPage

  layout :layout_for_page

  private

  def layout_for_page
    case params[:id]
    when 'bestinshow', 'element_pt1', 'colorwheel'
      'best'
    when 'sampler'
      'sampler'
    when 'video'
      'video'
    else
      'application'
    end
  end
end
