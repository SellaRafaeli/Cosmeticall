$.material.init();

$(document).ready(function() {
	$("#search").show();
});

function show_loader() {
	$("#search").hide(); 
	$("#supplier").hide();
	$("#results").hide();
	$("#loader").show();
	$("#results_button2").show();  
};

function show_contact_supplier() {
	$("#search").hide(); 
	$("#supplier").hide();
	$("#results").hide();
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
	$("#contact_supplier_form").show(); // ????? should be here?
};
function results_button(){
	$("#search").hide(); 
	$("#supplier").hide();
	$("#loader").hide();
	$("#contact_supplier").hide();
	$("#results").show();
	$("#results_button2").addClass('active');
	$("#search_button2").removeClass('active');
	$("#supplier_button2").removeClass('active');
	
};

function search_button(){
	$("#results").hide(); 
	$("#supplier").hide();
	$("#loader").hide();
	$("#contact_supplier").hide();
	$("#search").show();
	$("#results_button2").removeClass('active');
	$("#search_button2").addClass('active');
	$("#supplier_button2").removeClass('active');

};

function supplier_button(){
	$("#search").hide(); 
	$("#results").hide();
	$("#loader").hide();
	$("#supplier").show();
	$("#supplier_button2").show();
	$("#search_button2").removeClass('active');
	$("#results_button2").removeClass('active');
	$("#supplier_button2").addClass('active');
};

function contact_supplier() {
	var template = $('#user_details_phone').html();
	var rendered = Mustache.render(template, clicked_user);
	$("#contact_supplier_form").hide(); 
	$("#supplier_phone").show();
	$('#supplier_phone').html(rendered); // replace singleSupplier
};

function submitDetailsForm() {
	show_loader();
	var search_name = $("#search_name_input").val();
	var search_treatment = $("#search_treatment_input").val();
	var search_city = $("#search_city_input").val();
	$.ajax({
		url: '/search_ajax',
		type: 'post',
		dataType: 'json',
		data: {name: search_name, city: search_city, treatments:search_treatment},
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
	var user_code = $("#user_code").val();
	var user_phone = $("#phone_without_code").val();
	var description = $("#description").val();
	$.ajax({
		url: '/contact_supplier_ajax',
		type: 'post',
		dataType: 'json',
		data: {code: user_code, phone_without_code: user_phone, description:description},
		success: function(response) {
			console.log("succeeded in contact_supplier", response)
			contact_supplier();
			// show phone and thank u message 
			// hide form 
		}
		});
};

console.log("done running main.js");