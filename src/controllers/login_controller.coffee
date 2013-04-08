chrome.app.Controllers.Login = class LoginController
  login: (user, password) ->
    packet = new chrome.app.Packets.Login(user, password)
    packet.onReady Lineage.socket.send

  received: (packet) ->
    switch packet.id
      when PacketId.AuthResult
        if packet.success() is true
          Lineage.push( new chrome.app.Controllers.Characters )

        else
          #show error

  render: ->
    unless @$template?
      $.get @templateURL(), (text) =>
        @$template = $(text)
        @render()

      return this

    $(document.body).html(@$template)
    @eventify(@$template)

  templateURL: ->
    "/templates/login.html"

  eventify: ($html) ->
    $html.on "submit", =>
      username = $html.find("#login_username").val()
      password = $html.find("#login_password").val()
      @login(username, password)
      false


  receivedTemplate: (text) =>
    @template = $(text)

