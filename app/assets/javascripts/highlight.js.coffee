skyway.ready ->
  if highlightElement = $("[data-highlight]")
    highlight = highlightElement.data("highlight")

    highlightElement.find("em, h3, span").each ->
      if $(this).text().match(new RegExp(highlight, "i"))
        $(this).addClass("highlight")
