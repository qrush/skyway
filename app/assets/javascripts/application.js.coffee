#= require jquery
#= require jquery_ujs
#= require d3.min
#= require_self

#= require highlight
#= require menu
#= require spark

@skyway =
  ready: (func) ->
    $(document).ready(func)
