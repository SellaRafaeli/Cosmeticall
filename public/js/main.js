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


function my_requests_button() {
	$("#search").hide(); 
	$("#supplier").hide();
	$("#results").hide();
	$("#contact_supplier_form").hide(); 
	$("#contact_supplier").hide();
	$("#search_menu_button").show();
	$("#my_requests").show();
	$(".menuBtn").removeClass('active');
	$("#my_requests_menu_button").addClass('active');
};

function show_contact_supplier() {
	$("#search").hide(); 
	$("#results").hide();
	$("#my_requests").hide();
	$("#contact_supplier").show(); 

};


function click_user(user_id){

	// removed var here
	filtered_users = users_found.filter(function(user) { return user._id == user_id; });
	clicked_user   = filtered_users[0];
	var template = $('#user_details_template').html();
	var rendered = Mustache.render(template, clicked_user);

	$('#singleSupplier').html(rendered);
	supplier_button();
	$("#supplier_phone").hide();
	$("#my_requests").hide();
	$("#contact_supplier_form").show();
	$("#contact_supplier_button").show(); 
};
function results_button(){
	//use a class to hide many elements at once - $(".menuBtn").hide();
	$("#search").hide(); 
	$("#supplier").hide();
	$("#loader").hide();
	$("#contact_supplier").hide();
	$("#my_requests").hide();
	$("#results").show();
	$("#show").addClass('active');

	$("#search_menu_button").show();
	$(".menuBtn").removeClass('active');
	$("#results_menu_button").addClass('active');
};

function search_button(){
	$("#results").hide(); 
	$("#supplier").hide();
	$("#loader").hide();
	$("#contact_supplier").hide();
	$("#my_requests").hide();
	$("#search").show();
	$(".menuBtn").removeClass('active');
	$("#search_menu_button").addClass('active');
	

};

function supplier_button(){
	$("#search").hide(); 
	$("#results").hide();
	$("#loader").hide();
	$("#my_requests").hide();
	$("#supplier").show();
	$("#supplier_menu_button").show();
	$(".menuBtn").removeClass('active');
	$("#supplier_menu_button").addClass('active');
};

function contact_supplier() {
	var template_phone = $('#user_details_phone').html();
	var rendered_phone = Mustache.render(template_phone, clicked_user);
	$("#contact_supplier_form").hide(); 
	$("#supplier_phone").show();
	$("#contact_supplier_text").hide();  // ???
	$("#contact_supplier_button").hide();  // ???
	
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
			$('#resultsList').html(rendered);
			results_button();}
		});
};

function ContactSupplier() {
	// show_loader();
	var user_phone = $("#phone").val();
	if (user_phone.length < 18) {
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
			
			// // show phone and thank u message 
		}
		});
};

console.log("done running main.js");