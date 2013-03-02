class ChatPacket
  constructor: (@data, opcode) ->
    #check what kind of chat we have here
    switch opcode
      when 3
        @type = "global"
        @data = @data.int(@tid)
        @data = @data.string(@message)
      when 47
        @type = "whisper"
        @data = @data.string(@character)
        @data = @data.string(@message)
      when 71
        @type = "normal"
        @data = @data.int(@tid)
        @data = @data.long(@pid)
        @data = @data.string(@message)

  tid: => #Type Id
    return @_tid if arguments.length is 0
    @_tid = arguments[0]

  pid: => #Player Id
    return @_pid if arguments.length is 0
    @_pid = arguments[0]

  character: =>
    return @_character if arguments.length is 0
    @_character = arguments[0]

  message: =>
    console.log(arguments)
    return @_message if arguments.length is 0
    @_message = arguments[0]

chrome.app.Routes[3] = chrome.app.Routes[47] = chrome.app.Routes[71] = ChatPacket
