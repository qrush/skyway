superscripts = ["¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹"]

skyway.ready ->
  new Clipboard '[data-clipboard-text]',
    text: (trigger) ->
      setlist = $("[data-behavior~='setlist']").clone()

      for sup, index in superscripts
        setlist.find("sup:contains(#{index + 1})").replaceWith(sup)

      lines = setlist.text().split("\n")
      trimmed = ($.trim line for line in lines)
      $.trim trimmed.join("\n")
