chrome.app.Packets.Login = class LogPacket extends Packet

  constructor: (user, password) ->
    @user = user
    @password = password
    super(113)

    @buffer = {}

  length: ->
    # Add 2 for the two 0x00 we append to each string(user,pwd)
    super + @user.length + @password.length + 2

  append: (name, buffer) =>
    switch name
      when "user" then @buffer[0] = buffer
      when "password" then @buffer[1] = buffer

    if @buffer[0]? && @buffer[1]?
      idx = 1
      idx += @view.join @buffer[0], idx
      idx += @view.join [0x00], idx
      idx += @view.join @buffer[1], idx
      idx += @view.join [0x00], idx
      @packaged(@view)

  #Since I don't want to deal with racing conditions, and I don't want
  #to pre-optimize. I will bufferize both element one after the other. 
  #this way, we are certain that the buffer is properly filled and ready to go
  package: (view) =>
    @view = view
    @user.bufferize (user) =>
      @append "user", user

    @password.bufferize (pwd) =>
      @append "password", pwd


