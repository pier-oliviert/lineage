// Generated by CoffeeScript 1.4.0
(function() {
  var CharInfoPacket;

  chrome.app.Routes[102] = CharInfoPacket = (function() {

    CharInfoPacket.prototype.id = 102;

    function CharInfoPacket(data) {
      this.data(data);
      this.name = this.string(this.data());
      this.pledge = this.string(this.data());
    }

    CharInfoPacket.prototype.data = function() {
      if (arguments.length === 0) {
        return this.bytes;
      }
      return this.bytes = arguments[0];
    };

    CharInfoPacket.prototype.string = function(data) {
      var byte, chars, _i, _len;
      chars = [];
      for (_i = 0, _len = data.length; _i < _len; _i++) {
        byte = data[_i];
        if (byte === 0x00) {
          break;
        }
        chars[_i] = String.fromCharCode(byte);
      }
      this.data(data.subarray(++chars.length));
      return chars.join("");
    };

    return CharInfoPacket;

  })();

  PacketId.CharInfo = 102;

}).call(this);