class PlayerPacket
  id: 1
  constructor: (@data) ->
    @data.parse this,
      x: "long",
      y: "long"


  x: (pos) ->
    @x = (pos) ->
      return @x.value if arguments.length is 0
      @x.value = pos
      @x.value
    @x(pos)

  y: (pos) ->
    @y = (pos) ->
      return @y.value if arguments.length is 0
      @y.value = pos
      @y.value
    @y(pos)

  name: (name) ->
    console.log name

  pledge: (name) ->
    console.log name


chrome.app.Routes[1] = PlayerPacket
PacketId.Player = 1
