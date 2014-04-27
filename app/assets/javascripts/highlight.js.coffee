skyway.ready ->
  if highlightElement = $("[data-highlight]")
    highlight = highlightElement.data("highlight")

    highlightElement.find("em, h3").each ->
      if $(this).text().match(new RegExp(highlight, "i"))
        $(this).addClass("highlight")

  $('#js-mobile-menu').on 'click', (e) ->
    e.preventDefault()
    menu = $('#navigation-menu')
    menu.slideToggle ->
      if menu.is(':hidden')
        menu.removeAttr('style')
