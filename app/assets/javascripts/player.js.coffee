$(document).on "click", "[data-behavior~=play]", ->
  window.webkit.messageHandlers.player.postMessage
    "media-url": $(this).data("media-url")
