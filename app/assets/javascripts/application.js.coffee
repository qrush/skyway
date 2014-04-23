#//= require jquery
#//= require jquery_ujs
#//= require turbolinks
#//= require_tree .

$ ->
  if highlightElement = $("[data-highlight]")
    highlight = highlightElement.data("highlight")
    console.log highlight

    highlightElement.find("em, h3").each ->
      if $(this).text().match(new RegExp(highlight, "i"))
        $(this).addClass("highlight")

