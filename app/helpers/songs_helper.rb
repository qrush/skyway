module SongsHelper
  def playlist_buttons_for(playlist)
    Playlist::ORDERS.map do |(order, name)|
      options ||= {}
      options[:class] = "active" if playlist.order == order
      link_to name, songs_path(order: order), options
    end.join.html_safe
  end

  def last_performed_for(song_name)
    if song = Song.find_by_name(song_name)
      show = song.shows.first
      capture do
        concat "last performed on "
        concat link_to "#{show.short_when} @ #{show.venue.name}", show
      end
    else
      ""
    end
  end
end
