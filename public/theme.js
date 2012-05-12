!function($) {
  var comments = [];

  function addComment(text, author) {
    var data = { text: text };
    var template = getTemplate();
    var html = applyTemplate(data, template);

    $comment = $(html);
    $comment.appendTo($viewport);
    putOnRandom($comment);

    comments.unshift($comment);

    // update scale for comments in history
    for (var i = 0, l = comments.length; i < l; i++) {
      var $curComment = comments[i];
      $curComment.css('-webkit-transform', 'scale(' + (1 - 0.05*i) + ')');
    }

    var $curComment = comments[9];
    $curComment.css('-webkit-transform', 'scale(.00)');

    // remove last comment
    if (comments.length > 10) {
      var $lastComment = comments.pop();
      $lastComment.remove();
    }
  }

  function getTemplate() {
    return $('#template-comment').prop('text');
  }

  function applyTemplate(data, template) {
    return template.replace(/{#(\w+)}/g, function(m, key) {
      var text = data[key] || '';  // 該当なければ空文字列
      return text;
    });
  }

  function putOnRandom($comment) {
    var width = $comment.outerWidth();
    var height = $comment.outerHeight();
    var clientHeight = $viewport.height();
    var clientWidth = $viewport.width();

    $comment.css({
      left: ~~(Math.random() * (clientWidth - width)),
      top: ~~(Math.random() * (clientHeight - height))
    });
  }

  var $viewport = $('#viewport');
  setInterval(function() {
    addComment('やほう！');
  }, 1000);
}(jQuery);
