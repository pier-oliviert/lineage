// Generated by CoffeeScript 1.4.0
(function() {
  var Chat;

  chrome.app.Engine.Chat = Chat = (function() {

    function Chat(html) {
      this.$html = $(html);
      this.$types = this.$html.find("ul.types");
      this.$types.children(".global").addClass("active");
      this.$types.children("li").each(function() {
        return $(this).data("history", []);
      });
      this.$active = this.$types.children(".active");
      this.loaded = true;
    }

    Chat.prototype.html = function() {
      return this.$html;
    };

    Chat.prototype.received = function(packet) {
      return this.update(packet.type, this.compile(packet));
    };

    Chat.prototype.compile = function(packet) {
      return $("<li>" + (packet.message()) + "</li>");
    };

    Chat.prototype.update = function(type, $li) {
      var $el;
      $el = this.$types.find("." + type);
      $el.data("history").push($li);
      if (this.$active.hasClass(type)) {
        return this.$html.find(".history").append($li);
      }
    };

    Chat.prototype.toggle = function($element) {
      this.$html.find(".active").removeClass("active");
      $element.addClass("active");
      this.$active = $element;
      return this.$html.find(".history").html($element.data("history"));
    };

    return Chat;

  })();

}).call(this);