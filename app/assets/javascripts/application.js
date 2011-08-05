// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require common
//= require posts
//= require comments
//= require pages
//= require messages

function activePlaceholders() {
	var inputs = $("input");
	for(var i = 0; i < inputs.length; i++) {
		var input = inputs[i];
		console.log(input);

		if(input.attr("type") == "text") {
			if(input.attr("textholder") && input.attr("textholder").length > 0) {
				input.attr("value") = input.attr("textholder");
				input.click(function() {
					if($(this).attr("value") == $(this).attr("textholder")) {
						$(this).attr("value") = "";
					}
				});
				input.blur(function() {
					if($(this).attr("value").length < 1) {
						$(this).attr("value") = $(this).attr("textholder");
					}
				});
			}
		}
	}
}

$(function() {
	alert("htisdlfksldf");
	activePlaceholders();
});
