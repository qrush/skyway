#= require jquery
#= require jquery_ujs
#= require jwplayer

jwplayer.key = "RMvgim99iIA6JMnO0pelofjf2EOnWZEAelk/zA=="

@sampler = {}

$ =>
  if document.querySelector("[data-behavior~=download]")
    playlist = ({sources: [{file: download.dataset.songUrl}]} for download in document.querySelectorAll("[data-behavior~=download]"))
  else
    playlist = ({sources: [{file: item.dataset.track}]} for item in document.querySelectorAll("[data-track]"))

  return if playlist.length is 0

  @sampler.player = jwplayer('mediaplayer').setup
    id: 'playerID'
    controls: false
    provider: 'rtmp'
    streamer: 'rtmp://s2b7mnk1i05p4w.cloudfront.net/cfx/st/'
    playlist: playlist
    modes: [
      {type: 'html5', config: { provider: 'audio' }}
      {type: 'flash', src: '/jwplayer.flash.swf'}
    ]

$("[data-behavior~=download]").on "click", (event) ->
  $("[data-behavior~=play][data-song=#{$(this).data('song')}]").click()

$("[data-behavior~=play]").on "click", (event) ->
  $track = $(this)
  sampler.player.pause()

  if $track.attr("data-status") == "pause"
    $track.attr("data-status", "")
  else
    song = $track.data("song")
    sampler.player.playlistItem(song - 1)
    $track.attr("data-status", "pause")
    $("[data-behavior~=play]:not([data-song=#{song}])").attr("data-status", "")


  event.preventDefault()
