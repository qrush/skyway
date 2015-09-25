#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require d3.min
#= require_self

#= require highlight
#= require menu
#= require spark
#= require player

@skyway =
  ready: (func) ->
    $(document).ready(func)
