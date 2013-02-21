class @LogPacket extends Packet
  length: ->
    # Add 2 for the two 0x00 we append to each string(user,pwd)
    super + @user.length + @password.length + 2

  #Since I don't want to deal with racing conditions, and I don't want
  #to pre-optimize. I will bufferize both element one after the other. 
  #this way, we are certain that the buffer is properly filled and ready to go
  package: (view) ->
    idx = 1
    @user.bufferize (user) =>
      view.join(user, idx)
      idx += user.length
      view.join(0x00, ++idx)
      idx++

      @password.bufferize (pwd) =>
        view.join(pwd, idx)
        idx += pwd.length
        view.join(0x00, ++idx)
        idx++
        @packaged(view)


