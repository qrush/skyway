namespace :musicbrainz do
  desc 'Sync albums from musicbrainz'
  task albums: :environment do
    require 'musicbrainz'
    MusicBrainz.configure do |c|
      c.app_name = "Skyway"
      c.app_version = "1.0"
      c.contact = "nick@quaran.to"
    end

    aqueous = MusicBrainz::Artist.find("5df34416-d6dd-4692-b92d-86f81d724b9d")
    puts "Processing albums..."
    Album.transaction do
      aqueous.release_groups.each do |release_group|
        album = Album.find_or_initialize_by(name: release_group.title)
        album.released_on = release_group.first_release_date
        album.save!
      end
    end

    Song.transaction do
      aqueous.release_groups.each do |release_group|
        album = Album.find_by!(name: release_group.title)
        puts ">>> #{album.name}..."
        release_group.releases.first.tracks.each do |track|
          puts %{Processing "#{track.title}"}
          song = Song.find_by!(name: track.title)
          song.album = album
          song.album_position = track.position
          song.save!
        end
      end
    end
  end
end
