(function(){
	$('#text').fadeOut(2400, function(){
		$('#content form').animate({opacity:'show'});
	});

  (function() {
    var $text = $('#post_body');
    if ($text.length > 0) {
      var text = $text.val();
      $('#num').text(140 - text.length);
      setTimeout(arguments.callee, 100);
    }
  })();
})();
