$.material.init();

$(document).ready(function() {
	$("#search").show();
	//$("#search").hide();

});



function show_loader() {
	$("#search").hide(); 
	$("#supplier").hide();
	$("#results").hide();
	$("#loader").show();	
	$("#results_menu_button").show();  
};

function get_quote_button() {
	setCurrentState('get_quote_button');
	$("#search").hide(); 
	$("#supplier").hide();
	$("#results").hide();
	$("#contact_supplier").hide();
	$("#my_requests").hide();
	$("#get_quote").show();
	$(".menuBtn").removeClass('active');
	$("#get_quote_menu_button").addClass('active');
};

function my_requests_button() {
	setCurrentState('my_requests_button');
	$("#search").hide(); 
	$("#supplier").hide();
	$("#results").hide();
	$("#contact_supplier_form").hide(); 
	$("#contact_supplier").hide();
	$(".quote-msg").hide();
	$("#get_quote").hide();
	$("#search_menu_button").show();
	$("#my_requests").show();
	$(".menuBtn").removeClass('active');
	$("#my_requests_menu_button").addClass('active');
};

function show_contact_supplier() {
	setCurrentState('show_contact_supplier');
	$("#search").hide(); 
	$("#results").hide();
	$("#my_requests").hide();
	$(".quote-msg").hide();
	$("#get_quote").hide();
	$("#contact_supplier").show(); 

};


function click_user(user_id){
	// removed var here
	setCurrentState('-');	
	filtered_users = users_found.filter(function(user) { return user._id == user_id; });
	clicked_user   = filtered_users[0];
	var template = $('#user_details_template').html();
	var rendered = Mustache.render(template, clicked_user);

	$('#singleSupplier').html(rendered);
	supplier_button();
	$("#supplier_phone").hide();
	$("#thank_you_send_sms").hide();
	$("#my_requests").hide();
	$("#contact_supplier_form").show();
	$("#contact_supplier_button").show(); 
};
function results_button(){
	setCurrentState('results_button')
	//use a class to hide many elements at once - $(".menuBtn").hide();
	$("#search").hide(); 
	$("#supplier").hide();
	$("#loader").hide();
	$("#contact_supplier").hide();
	$("#my_requests").hide();
	$(".quote-msg").hide();
	$("#get_quote").hide();
	$("#results").show();
	$("#show").addClass('active');

	$("#search_menu_button").show();
	$(".menuBtn").removeClass('active');
	$("#results_menu_button").addClass('active');
};

function search_button(){
	setCurrentState('search_button')
	$("#results").hide(); 
	$("#supplier").hide();
	$("#loader").hide();
	$("#contact_supplier").hide();
	$("#my_requests").hide();
	$(".quote-msg").hide();
	$("#get_quote").hide();
	$("#search").show();
	$(".menuBtn").removeClass('active');
	$("#search_menu_button").addClass('active');
};

function supplier_button(){
	$("#search").hide(); 
	$("#results").hide();
	$("#loader").hide();
	$("#my_requests").hide();
	$(".quote-msg").hide();
	$("#get_quote").hide();
	$("#supplier").show();
	$("#supplier_menu_button").show();
	$(".menuBtn").removeClass('active');
	$("#supplier_menu_button").addClass('active');
};

function contact_supplier() {
	setCurrentState('contact_supplier')
	var template_phone = $('#user_details_phone').html();
	var rendered_phone = Mustache.render(template_phone, clicked_user);
	$("#contact_supplier_form").hide(); 
	$("#supplier_phone").show();
	$("#thank_you_send_sms").show();
	$("#contact_supplier_text").hide(); 
	$("#contact_supplier_button").hide();  
	
	$('#supplier_phone').html(rendered_phone); // replace singleSupplier


	// var template = $('#user_details_template').html();
	// var rendered = Mustache.render(template, clicked_user);
	// $("#singleSupplier").show();  //PPPP
	// $('#singleSupplier').html(rendered); // PPPPP
	

};

function submitDetailsForm() {
	show_loader();
	var search_name = $("#search_name_input").val();
	var search_treatment = $("#search_treatment_input").val();
	var search_city = $("#search_city_input").val();
	var search_home_visits = $("#search_home_visits_input").is(':checked');
	$.ajax({
		url: '/search_ajax',
		type: 'post',
		dataType: 'json',
		data: {name: search_name, city: search_city, treatments:search_treatment, home_visits: search_home_visits},
		success: function(response) {
			users_found = response.users;
			var template = $('#found_users_template').html();
			var rendered = Mustache.render(template, response);
			var found_count = "Found " + users_found.length + " users";
			$('#resultsList').html(rendered);
			$('#users_count').html(found_count);
			results_button();}

		});
};

function verifyQuoteForm(){
         //var options = $('#quote_treatments > option:selected');
         var options = $('.treatment_option:selected');
         var options_address = $('#autocomplete_quote_address');
          if(options_address.val() == 0){
             alert('please enter address');
             return false;
         };
         debugger
         if(options.length == 0){
             alert('please select one or more treatments');
             return false;
    };
    return true;
};


function submitGetQuoteForm() {
	var formOK = verifyQuoteForm()
	if (formOK == false) { 
		console.log('form bad; stopping.')
		return false;
	}

	show_loader();
	$("#results_menu_button").hide(); 
	var phone = $("#quote_phone").val();
	var month = $("#quote_month").val();
	var day = $("#quote_day").val();
	var time_from = $("#quote_time_from").val();
	var time_to = $("#quote_time_to").val();
	var at_home = $("#quote_at_home").is(':checked');
	var latitude = $("#lat").val();
	var longitude = $("#lng").val();
	var treatments = $("#quote_treatments").val();
	var address = $("#autocomplete_quote_address").val();
	$.ajax({
		url: '/create_quote',
		type: 'post',
		dataType: 'json',
		data: {
		phone:phone,
		month:month,
 		day:day,
 		time_from:time_from,
 		time_to:time_to,
		at_home:at_home,
		latitude:latitude,
		longitude:longitude,
		treatments:treatments,
		address:address
		},
		success: function(response) {
			if ( response.quote.sellers_sent_to.length < 1) {
				console.log(response.quote.sellers_sent_to.length)
			$("#loader").hide();
			$("#get_quote").hide();
			$("#get_quote_menu_button").hide();
			$("#send_quote_no_sellers").show();
			} else {
    		$("#loader").hide();
			$("#get_quote").hide();
			$("#get_quote_menu_button").hide();
			$("#send_quote_thank_you").show();}
			}
		});
};

function ContactSupplier() {
	// show_loader();
	var user_phone = $("#phone").val();
	if ( user_phone && (user_phone.length > 1) && (user_phone.length < 18) ) {
		alert("Please enter your full phone.");
		return;
	}

	var description = $("#description").val();
	var supplier_phone = clicked_user["phone"];

	$.ajax({
		url: '/contact_supplier_ajax',
		type: 'post',
		dataType: 'json',
		data: {phone: user_phone, description:description, supplier_phone:supplier_phone},
		success: function(response) {
			console.log("succeeded in contact_supplier", response)
			contact_supplier();
		},
 		error: function(){contact_supplier();}
		});
};

function appendImgInput(event) {
	$("#profilePicUploader").hide();
  $("#profile_pic_input").val(event.fpfile.url);
  $("#profile_pic_img").attr('src',(event.fpfile.url));
}
console.log("done running main.js");


window.onpopstate = function(event) {
	try {
		func = event.state.func;
	  window[func]();	
	} catch(e) {
		history.back();
	}
};

function setCurrentState(func) {
	curState = history && history.state && history.state.func 
	if (curState !== func) {
		history.pushState({func: func}, '/', '/'); 
	}
}
setCurrentState('search_button') //first 'history' entry'		