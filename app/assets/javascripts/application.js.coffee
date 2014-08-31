#= require jquery
#= require jquery_ujs
#= require d3.min
#= require_self
#= require_tree .

@skyway =
  ready: (func) ->
    $(document).ready(func)
    #$(document).on('page:load', func)
