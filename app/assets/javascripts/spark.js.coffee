skyway.ready ->
  songs = $("#songs")
  if songs.length > 0
    showIds = songs.data("show-ids")

    height = 16
    labelOffset = 30

    svg = d3.select("#sparkline").
      append("svg:svg").
      attr("height", height).
      attr("width", showIds.length + labelOffset)

    node = svg.
      selectAll("g").
      append("svg:g")

    songs.find("[data-performed-show-ids]").each ->
      clone = svg.node().cloneNode(true)
      song = $(this)

      $("#spark_#{song.attr('id')}").append(clone)

      performedShowIds = song.data("performed-show-ids")
      if performedShowIds.length > 0
        calculateY = (showId) ->
          if performedShowIds.indexOf(showId) == -1
            height / 2
          else
            0

        d3.select(clone).append("svg:text")
          .attr("x", labelOffset - 7)
          .attr("y", 13)
          .style("text-anchor", "end")
          .text(performedShowIds.length)

        clonedNode = d3.select(clone).selectAll("g").data(showIds).enter()
        clonedNode.append("svg:rect")
          .attr("x", (d, i) -> (i/2.0) * 2 + labelOffset)
          .attr("y", calculateY)
          .attr("height", height / 2)
          .attr("width", 0.5)
