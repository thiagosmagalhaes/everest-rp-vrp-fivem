$(document).ready(function(){
	window.addEventListener("message",function(event){
		$("#simplehud").html("<div id='textdiv'>Hoje é dia "+event.data.dia+" de "+event.data.mes+" - "+event.data.hora+":"+event.data.minuto+"<br>Você está na <b>"+event.data.rua+"</b>"+event.data.radio+"</div><div id='voice"+event.data.voz+"'></div>");
	})
});