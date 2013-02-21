class @Socket
  constructor: (ip, port) ->
    @socket = chrome.socket
    @socketId = -1
    @encryptor = new Encryptor()
    @decryptor = new Decryptor()

    @socket.create "tcp", {}, (info) =>
      @socketId = info.socketId
      console.log "Connecting to #{ip}:#{port}"
      @socket.connect @socketId, ip, port, @connected

  connected: (e) =>
    if e is 0
      console.log "Connected to server"
      setInterval(@bufferize, 500)
    else
      throw "Couldn't connect to server. Please restart the application"

  bufferize: =>
    @socket.read(@socketId, null, @received)

  received: (packet) =>
    return unless packet.data.byteLength
    @decryptor.process(packet.data)

  ###
  #   Discussion: How the server handles the length of a packet goes as follow:
  #   If a packet is smaller than 256bytes, the high byte is used. If however, the message is
  #   bigger than 256bytes, you use the low byte as a multiplicator. 
  #   The length of a packet is assumed to be: lowByte * 256 + highByte
  ###
  send: (data) =>
    data = @encryptor.process(data)
    size = data.length + 2

    packet = new Int8Array(new ArrayBuffer(size))
    packet[0] = size % 256
    packet[1] = (size / 256) & 0xFF
    packet.join(data, 2)
    console.log(packet.buffer)
    @socket.write @socketId, packet.buffer, (e) ->
      console.log(e)

