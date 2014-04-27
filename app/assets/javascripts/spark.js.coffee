skyway.ready ->
  songs = $("#songs")
  if songs.length > 0
    showIds = songs.data("show-ids")

    height = 16
    songs.find("[data-performed-show-ids]").each ->
      song = $(this)
      performedShowIds = song.data("performed-show-ids")
      if performedShowIds.length > 0
        svg = d3.select("#spark_#{song.attr('id')}").append("svg:svg").attr("height", height).attr("width", showIds.length * 2)
        node = svg.selectAll("g.tick").data(showIds).enter().append("svg:g").attr("class", "tick")

        calculateY = (showId) ->
          if performedShowIds.indexOf(showId) == -1
            height / 2
          else
            0

        node.append("svg:rect")
            .attr("x", (d, i) -> i * 2 + 1)
            .attr("y", calculateY)
            .attr("height", height / 2)
            .attr("width", 1)
