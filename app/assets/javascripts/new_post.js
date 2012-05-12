(function(){
	$('#text').fadeOut(2400, function(){
		$('#content form').animate({opacity:'show'});
	});

  (function() {
    var text = $('#post_body').val();
    if (text) {
      $('#num').text(140 - text.length);
      setTimeout(arguments.callee, 100);
    }
  })();
})();
