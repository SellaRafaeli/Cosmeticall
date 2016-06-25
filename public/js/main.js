$.material.init();

function show_loader() {
	$("#search").hide(); 
	$("#supplier").hide();
	$("#results").hide();
	$("#loader").show();
};

function click_user(user_id){
	var filtered_users = users_found.filter(function(user) { return user._id == user_id; });
	var clicked_user   = filtered_users[0];
	var template = $('#template').html();
	var rendered = Mustache.render(template, clicked_user);
	$('#singleSupplier').html(rendered);
	supplier_button();
};
function results_button(){
	$("#search").hide(); 
	$("#supplier").hide();
	$("#loader").hide();
	$("#results").show();
};

function search_button(){
	$("#results").hide(); 
	$("#supplier").hide();
	$("#loader").hide();
	$("#search").show();
};

function supplier_button(){
	$("#search").hide(); 
	$("#results").hide();
	$("#loader").hide();
	$("#supplier").show();
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
			var template = $('#template').html();
			var rendered = Mustache.render(template, response);
			$('#resultsList').html(rendered);
			results_button();}
		});
}


console.log("done running main.js");