module SongsHelper
  def playlist_buttons_for(playlist)
    Playlist::ORDERS.map do |(order, name)|
      options ||= {}
      options[:class] = "active" if playlist.order == order
      link_to name, songs_path(order: order), options
    end.join.html_safe
  end

  def random_lyric(lyrics)
    lyrics.split("\r\n")
          .map { |lyric| lyric.downcase.strip }
          .select(&:present?)
          .sample
  end
end
