class ChatPacket extends chrome.app.Packets.ReceivedPacket
  types:
    0: "normal"
    2: "shouting"
    3: "global"
    4: "clan"
    9: "whisper"
    12: "trade"
    16: "whisper"
  
  constructor: (@data, opcode) ->
    #check what kind of chat we have here
    switch opcode
      when 3
        @attributes @data,
          tid: "int8",
          message: "string"
      when 9
        @attributes @data,
          tid: "int8",
          message: "string"
      when 47
        @type = -> "whisper"
        @attributes @data,
          character: "string",
          message: "string",
      when 71
        @attributes @data,
          tid: "int8",
          pid: "int32",
          message: "string"

  type: ->
    @types[@tid()]


chrome.app.Routes[3] = chrome.app.Routes[47] = chrome.app.Routes[71] = ChatPacket
