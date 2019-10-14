$(document).ready(function(){
	window.addEventListener("message",function(event){
		var html = "<div id='"+event.data.css+"'>"+event.data.mensagem+"</div>"
		$(html).appendTo("#notifications").hide().fadeIn(1000).delay(5000).fadeOut(1000);
	})
});