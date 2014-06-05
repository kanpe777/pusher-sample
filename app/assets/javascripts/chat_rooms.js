$(function() {
  if ($('#data_storage').data('pusher-key')) {
    Pusher.log = function(message) {
      if (window.console && window.console.log) {
        console.log(message);
      }
    };

    var pusherKey = $('#data_storage').data('pusher-key');
    var pusher = new Pusher(pusherKey);
    var channelName = 'channel_' + $('#data_storage').data('room-id');
    var channel = pusher.subscribe(channelName);
    channel.bind('chat_event', function(data) {
      if (data.id == $('#data_storage').data('room-id')) {
        $("ul").append("<li>" + data.message["date"] + "-" + data.message["speaker"] + "</li>");
        $("ul").append(data.message["content"]);
      }
    });

    $("#post").click(function(){
      $.ajax({
        type: "post",
        url: "message",
        data: "id=" + $('#data_storage').data('room-id') + "&data=" + $('#text').val()
      });
    });
  }
})
