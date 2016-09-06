$(document).ready(function() {

	if(document.getElementById("analysis-data")){
		$("#analysis-data").dataTable();
	}

	// Clustered Building Rent
	// if(document.getElementById('barChart')){
	// 	var alternative_view2 = "gross";
 	//    	var all_data2          = {};
	// 	// init checkbox unchecked
	// 	$("#clustered_building_rent input").attr("checked", false);
	// 	// immediate filter set
	// 	$("#clustered_building_rent .set_gross").on("click", function(e){
	// 		alternative_view2 = "gross";
	// 		draw_chart2(all_data2);
	// 	});
	// 	$("#clustered_building_rent .set_net").on("click", function(e){
	// 		alternative_view2 = "net";
	// 		draw_chart2(all_data2);
	// 	});
	// 	// init chart view - none
	// 	init_chart2();
	// 	// apply filter
	// 	$('#clustered_building_rent .apply-filter').on("click", function(e){
	// 		var filter_list = [];
	// 		$("#clustered_building_rent input").each(function(){
	// 			if(this.checked){
	// 				filter_list.push(this.value)
	// 			}
	// 		});
	// 		var from_date = $.datepicker.formatDate("dd-mm-yy",from.datepicker("getDate"));
	// 		var to_date   = $.datepicker.formatDate("dd-mm-yy",to.datepicker("getDate"));

	// 		$.get( "/analyses/ppsf_filter2",
	// 			{
	// 				from_date   : from_date,
	// 				to_date     : to_date,
	// 				filter_list : filter_list
	// 			},
	// 			function( result ) {
	// 				all_data2 = result;
	// 				console.log(result);
	// 				draw_chart2();
	// 			}
	// 		);
	// 	});
	// 	// start - end date
	// 	var dateFormat = "mm/dd/yy";
	// 	var from = $("#from")
	// 		.datepicker({
	// 			defaultDate: "+1w",
	// 			changeMonth: true,
	// 			changeYear: true,
	// 			numberOfMonths: 1
	// 		})
	// 		.on("change", function() {
	// 			to.datepicker( "option", "minDate", getDate( this ) );
	// 		});
	// 	var to = $( "#to" )
	// 		.datepicker({
	// 			defaultDate: "+1w",
	// 			changeMonth: true,
	// 			changeYear: true,
	// 			numberOfMonths: 1
	// 		})
	// 		.on("change", function() {
	// 			from.datepicker( "option", "maxDate", getDate( this ) );
	// 		});
	// 	var from_day = new Date(), to_day = from_day.setDate(from_day.getDate() - 30);
	// 	to.datepicker("setDate", to_day);
	// 	from.datepicker("setDate", from_day);
	// 	to.datepicker("option", "maxDate", new Date());
	// 	from.datepicker("option", "maxDate", new Date());
	// 	function getDate( element ) {
	// 		var date;
	// 		try {
	// 			date = $.datepicker.parseDate( dateFormat, element.value );
	// 		} catch( error ) {
	// 			date = null;
	// 		}
	// 		return date;
	// 	}
	// 	function init_chart2() {
	// 		var bar_ctx = $("#barChart");

	// 		var barData = {
	// 	    labels: ["Chocolate", "Vanilla", "Strawberry"],
	// 		    datasets: [
	// 		        {
	// 		            label: "Blue",
	// 		            backgroundColor: "blue",
	// 		            data: [2,3]
	// 		        },
	// 		        {
	// 		            label: "Red",
	// 		            backgroundColor: "red",
	// 		            data: [1]
	// 		        },
	// 		        {
	// 		            label: "Green",
	// 		            backgroundColor: "green",
	// 		            data: [3]
	// 		        }
	// 		    ]
	// 		};

	// 		var barOptions = {
	// 			scaleStartValue : 0,
	// 			scales: {
	// 	            xAxes: [{
	// 	                    barPercentage: 0.8
	// 	            }],
	// 	            yAxes: [{
	// 	            	ticks: {
	// 	                    min: 0
	// 	            	}
	// 	            }]
	// 	        }
	// 		};

	// 		var barChart = new Chart(bar_ctx, {
	// 		    type: 'bar',
	// 		    data: barData,
	// 		    options: barOptions
	// 		});
	// 	}
	// 	function draw_chart2() {
	// 		$("#clustered_building_rent .chart-container").html('<canvas width="400" height="200"></canvas>');
	// 		var ctx = $("#clustered_building_rent canvas");
	// 		var data;
	// 		var chart_data = {
	// 			labels: [],
	// 			datasets: [{
	// 				label : "hey",
	// 				backgroundColor : [],
	// 				data : []
	// 			}]
	// 		}

	// 		switch (alternative_view2){
	// 			case "gross":
	// 				data = all_data2.data.gross
	// 				break;
	// 			case "net":
	// 				data = all_data2.data.net
	// 				break;
	// 		}
	// 		console.log(data);
	// 		console.log(data.length);

	// 		if(data.length) {
	// 			$.each(data, function(index, item){

	// 				chart_data.labels.push(item.geo);

	// 				var random_color = '#'+Math.floor(Math.random()*16777215).toString(16);
	// 				chart_data.datasets[0].backgroundColor.push(random_color);
	// 				chart_data.datasets[0].data.push(item.val);
	// 			});

	// 			var barOptions = {
	// 				scaleStartValue : 0,
	// 				scales: {
	// 		            xAxes: [{
	// 		                    barPercentage: 0.8
	// 		            }],
	// 		            yAxes: [{
	// 		            	ticks: {
	// 		                    min: 0
	// 		            	}
	// 		            }]
	// 		        }
	// 			};

	// 			var barChart = new Chart(ctx, {
	// 			    type: 'bar',
	// 			    data: chart_data,
	// 			    options: barOptions
	// 			});
	// 		} else {
	// 			init_chart2();
	// 		}
	// 	}
	// }
} );