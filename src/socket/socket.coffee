class @Socket

  constructor: (ip, port) ->
    @socket = chrome.socket
    @socketId = -1
    @encryptor = new Encryptor()
    @decryptor = new Decryptor()

    @buffer = new Buffer

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
    return unless packet.resultCode > 0

    receivingPacket = (packet) =>
      return unless packet.resultCode > 0

      if @buffer.empty()
        @buffer.initialize( new Uint8Array(packet.data) )
      else
        @buffer.append( new Uint8Array(packet.data) )

      while @buffer.full()
        @process @buffer.data()
        
    @received = receivingPacket

  process: (encryptedData) =>
    data = @decryptor.process( new Uint8Array(encryptedData) )
    opcode = data[0]

    if chrome.app.Routes[opcode]?
      Lineage.current().received( new chrome.app.Routes[opcode](data.subarray(1)) )


  ###
  #   Discussion: How the server handles the length of a packet goes as follow:
  #   If a packet is smaller than 256bytes, the high byte is used. If however, the message is
  #   bigger than 256bytes, you use the low byte as a multiplicator. 
  #   The length of a packet is assumed to be: lowByte * 256 + highByte
  #
  #   Discussion: We assume the packet size is at least 4 bytes long. Otherwise, it would disconnect us
  #   from the server. If the packet is less than 4 bytes, we raise an exception and return without sending it
  ###
  send: (data) =>
    if data.length < 4
      throw "Packet size error: A packet with a size less than 4 bytes was about to be sent"
      return
    data = @encryptor.process(data)
    size = data.length + 2

    packet = new Int8Array(size)
    packet[0] = size % 256
    packet[1] = (size / 256) & 0xFF
    packet.join(data, 2)

    @socket.write @socketId, packet.buffer, (e) ->
