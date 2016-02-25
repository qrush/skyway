#= require jquery
#= require jquery_ujs
#= require d3.min
#= require clipboard.min
#= require_self

#= require highlight
#= require menu
#= require spark
#= require player
#= require clipboard

@skyway =
  ready: (func) ->
    $(document).ready(func)
