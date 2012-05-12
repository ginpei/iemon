(function(){
	$('#text').fadeOut(2400, function(){
		$('#content form').animate({opacity:'show'});
	});

  setInterval(function() {
    $('#num').text(140 - $('#post_body').val().length);
  }, 100);
})();
