chrome.app.Packets.Login = class LogPacket extends Packet

  constructor: (user, password) ->
    super(113, ["user", "password"])
    @user user
    @password password

  user: ->
    return if arguments.length is 0
    @process( arguments[0], "user")

  password: ->
    return if arguments.length is 0
    @process( arguments[0], "password")

  length: ->
    super + @user().length + @password().length

  package: (buffer) ->
    buffer.join @user(), 1
    buffer.join @password(), @user().length + 1
