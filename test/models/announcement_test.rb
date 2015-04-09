require 'test_helper'

class AnnouncementTest < ActiveSupport::TestCase
  test "embed url is parsed from video" do
    announcement = Announcement.new(video: "https://www.youtube.com/watch?v=_2Bw2AQzVrA")
    assert_equal "//www.youtube.com/embed/_2Bw2AQzVrA", announcement.embed_url
  end

  test "embed url is parsed from unprefixed URL" do
    announcement = Announcement.new(video: "youtube.com/watch?v=_2Bw2AQzVrA")
    assert_equal "//www.youtube.com/embed/_2Bw2AQzVrA", announcement.embed_url
  end

  test "embed url has a fallback if correct URL not provided" do
    # from http://stackoverflow.com/questions/15700784/how-to-fix-bad-uri-is-not-uri
    announcement = Announcement.new(video: "youtube.com/bananas")
    assert_equal "//www.youtube.com/embed/ol1rKB55lVU", announcement.embed_url
  end

  test "embed url has a fallback if no URL is there" do
    announcement = Announcement.new
    assert_equal "//www.youtube.com/embed/ol1rKB55lVU", announcement.embed_url
  end

  test "embed url has a fallback if parsing failed" do
    # from http://stackoverflow.com/questions/15700784/how-to-fix-bad-uri-is-not-uri
    announcement = Announcement.new(video: "https://youtube.com/view-share/playerp/?plContext=http://ferrari-%201363948628-stream.4mecloud.it/live/ferrari/ngrp:livegenita/manifest.f4m&cartellaConfig=http://ferrari-4me.weebo.it/static/player/config/&cartellaLingua=http://ferrari-4me.weebo.it/static/player/config/&poster=http://pusher.newvision.it:8080/resources/img1.jpg&urlSkin=http://ferrari-4me.weebo.it/static/player/swf/skin.swf?a=1363014732171&method=GET&target_url=http://ferrari-4me.weebo.it/static/player/swf/player.swf&userLanguage=IT&styleTextColor=#000000&autoPlay=true&bufferTime=2&isLive=true&highlightColor=#eb2323&gaTrackerList=UA-23603234-4")
    assert_equal "//www.youtube.com/embed/ol1rKB55lVU", announcement.embed_url
  end
end
