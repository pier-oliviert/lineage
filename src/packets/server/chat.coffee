class ChatPacket extends chrome.app.Packets.ReceivedPacket
  constructor: (@data, opcode) ->
    #check what kind of chat we have here
    switch opcode
      when 3
        @type = "global"
        @attributes @data,
          tid: "int8",
          message: "string"
      when 47
        @type = "whisper"
        @attributes @data,
          character: "string",
          message: "string",
      when 71
        @type = "normal"
        @attributes @data,
          tid: "int8",
          pid: "int16",
          message: "string"

chrome.app.Routes[3] = chrome.app.Routes[47] = chrome.app.Routes[71] = ChatPacket
