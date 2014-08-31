skyway.ready ->
  $('#js-mobile-menu').on 'click', (e) ->
    e.preventDefault()
    menu = $('#navigation-menu')
    menu.slideToggle ->
      if menu.is(':hidden')
        menu.removeAttr('style')
