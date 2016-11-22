$.material.init();

$(document).ready(function() {
	$("#search").show();
	//$("#search").hide();

});

window.CM = {}; //Cosmeticall global object

function show_loader() {
	$("#search").hide(); 
	$("#supplier").hide();
	$("#results").hide();
	$("#loader").show();
	$("#results_menu_button").show();
}

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
	setCurrentState('results_button');
	//use a class to hide many elements at once - $(".menuBtn").hide();
	$("#search").hide(); 
	$("#supplier").hide();
	$("#loader").hide();
	$("#contact_supplier").hide();
	$("#my_requests").hide();
	$(".quote-msg").hide();
	$("#get_quote").hide();
	$("#results").show().show();
	$("#show").addClass('active');

	$("#search_menu_button").show();
	$(".menuBtn").removeClass('active');
	$("#results_menu_button").addClass('active');
};

function search_button(){
	//alert('search button')
	//setCurrentState('search_button')
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
			var found_count = "מצאנו " + users_found.length + " אנשי מקצוע";
			$('#resultsList').html(rendered);
			$('#users_count').html(found_count);
			CM.users_to_send_quote = [] // save users we found in this arry, to later send quote to them. how to grab this in different function?
			for (i in users_found) {
				CM.users_to_send_quote.push(users_found[i]["phone"]);

			};
			results_button();}

		});
};

function verifyQuoteForm(){
         //var options = $('#quote_treatments > option:selected');
         var options = $('.treatment_option:selected');
         var options_address = $('#autocomplete_quote_address');
         var options_phone = $('#quote_phone_modal');
         if(options_address.val() == 0){
             alert('please enter address');
             return false;
         };
         if(options_phone.val().length < 10){	
             alert('please enter full phone');
             return false;
         };
         if(options.length == 0){
             alert('please select one or more treatments');
             return false;
    };
    return true;
};


function checkPhoneEntered(){
    var options_phone = $('#phone_field');
    if(options_phone.val().length < 10){	
    alert('please enter full phone');
    console.log('form bad; stopping.')
    return false;
    };
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
	var time_around = $("#quote_time_around").val();
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
 		time_around:time_around,
		at_home:at_home,
		latitude:latitude,
		longitude:longitude,
		treatments:treatments,
		address:address
		},
		success: function(response) {
			if ( response.quote.sellers_sent_to.length < 1) {
			$("#loader").hide();
			$("#get_quote").hide();
			$("#get_quote_menu_button").hide();
			$("#send_quote_no_sellers").show();
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
	var user_phone = $("#user_phone_for_sms").val();
	if ( user_phone && (user_phone.length > 1) && (user_phone.length < 10) ) {
		alert("המספר לא תקין.");
		return;
	}

	var description = $("#description").val();
	if ( description.length < 5) {
		alert("הודעה קצרה מדי! :)");
		return;
	}


	var supplier_phone = clicked_user["phone"];
	if ($("#user_phone_for_sms").length && !user_phone) {
		alert("נא להכניס את המספר שלך.");
		return;
	}
	$.ajax({
		url: '/contact_supplier_ajax',
		type: 'post',
		dataType: 'json',
		data: {phone: user_phone, description:description, supplier_phone:supplier_phone},
		success: function(response) {
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


function back_button(event) {
	try {
		function_name = event.state.function_name;
	  window[function_name]();	
	} catch(e) {
		history.back();
	}
};


//window.onpopstate = back_button;

function setCurrentState(function_name) {
	curState = history && history.state && history.state.function_name 
	if (curState !== function_name) {
		history.pushState({function_name: function_name}, '/', '/'); 
	}
}

function verifyQuoteFormModal(){
	var options_phone = $('#quote_phone_modal');
	var address = $("#autocomplete_quote_address").val();
 
  if(options_phone.val().length < 10){	
     alert('please enter full phone');
     return false;
  };


  return true;
};

function submitGetQuoteFormModal() {
	var formOK = verifyQuoteFormModal()
	if (formOK == false) { 
		console.log('form bad; stopping.')
		return false;
	}

	show_loader();
	$("#results_menu_button").hide();
	var phone = $("#quote_phone_modal").val();
	var month = $("#quote_month_modal").val();
	var day = $("#quote_day_modal").val();
	var time_around = $("#quote_time_around_modal").val();
	var at_home = $("#search_home_visits_input").is(':checked');
	var area = $("#search_city_input").val();
	var address = $("#autocomplete_quote_address").val();
	var sellers_sent_to = CM.users_to_send_quote;
	// var latitude = $("#lat").val();
	// var longitude = $("#lng").val();
	var treatments = $("#search_treatment_input").val();
	// var address = $("#autocomplete_quote_address").val();
	$.ajax({
		url: '/create_quote_modal',
		type: 'post',
		dataType: 'json',
		data: {
		phone:phone,
		month:month,
		address: address,
 		day:day,
 		address: address,
 		time_around:time_around,
		at_home:at_home,
		area:area,
		sellers_sent_to:sellers_sent_to,
		// latitude:latitude,
		// longitude:longitude,
		// address:address,
		treatments:treatments,
		
		},
		success: function(response) {
			if ( response.quote.sellers_sent_to.length < 1) {
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