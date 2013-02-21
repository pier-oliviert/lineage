# Live: 98.248.13.98
class Lineage
  constructor: ->
    @socket = new Socket("127.0.0.1", 2000)
    @controllers = []


  log: (user, pwd) =>
    packet = new LogPacket(113)
    packet.user = user
    packet.password = pwd
    packet.bufferize (buffer) =>
      @socket.send(buffer)

    packet

    
@Lineage = new Lineage()
