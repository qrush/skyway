$(document).delegate '[data-attended]', 'ajax:complete', ->
  toggled = !$(this).data('attended')
  $(this).data('attended', toggled).attr('data-attended', toggled)
  $(this).text $(this).attr("data-attended-#{toggled}-text")
