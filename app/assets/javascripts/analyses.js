$(document).ready(function() {

	if(document.getElementById("analysis-data")){
		$("#analysis-data").dataTable();
	}

    // Rental Price Trend Over Time
    if(document.getElementById('rental_price_trend_over_time')){

    	var show_filter       = "year";
    	var alternative_view1 = "gross";
    	var all_data1          = {};

    	// init chart view - none
    	init_chart1();

        // init checkbox unchecked
		$("#rental_price_trend_over_time input").attr("checked", false);


		// immediate filter set
		$("#rental_price_trend_over_time .set_by_year").on("click", function(e){
			show_filter = "year";
			draw_chart1();
		});
		$("#rental_price_trend_over_time .set_by_quarter").on("click", function(e){
			show_filter = "quarter";
			draw_chart1();
		});
		$("#rental_price_trend_over_time .set_by_month").on("click", function(e){
			show_filter = "month";
			draw_chart1();
		});
		$("#rental_price_trend_over_time .set_gross").on("click", function(e){
			alternative_view1 = "gross";
			draw_chart1();
		});
		$("#rental_price_trend_over_time .set_net").on("click", function(e){
			alternative_view1 = "net";
			draw_chart1();
		});

		// apply filter
		$('#rental_price_trend_over_time .apply-filter').on("click", function(e){
			var filter_list = [];
			$("#rental_price_trend_over_time input").each(function(){
				if(this.checked){
					filter_list.push(this.value)
				}
			});
			console.log(filter_list);

			if(filter_list.length) {
				$.get( "/analyses/ppsf_filter1",
					{
						filter_list : filter_list
					},
					function( result ) {
						all_data1 = result;
						draw_chart1();
					}
				);
			} else {
				init_chart1();
			}
		});

		function draw_chart1() {
			$("#rental_price_trend_over_time .chart-container").html('<canvas width="400" height="200"></canvas>');
			var ctx = $("#rental_price_trend_over_time canvas");
			console.log(ctx);
			var data;
			var chart_data = {
				labels: [],
				datasets: []
			}

			switch (alternative_view1){
				case "gross":
					data = all_data1.data.gross
					break;
				case "net":
					data = all_data1.data.net
					break;
			}

			switch (show_filter){
				case "year":
					data = data.year;
					chart_data.labels = [2015, 2016];
					break;
				case "quarter":
					data = data.quarter;
					for (i = 1; i <= 4; i++) {
						chart_data.labels.push("Q" + i + "-" + "2016");
					}
					break;
				case "month":
					data = data.month;
					for (i = 1; i <= 12; i++) {
						chart_data.labels.push("2016-" + i);
					}
					break;
			}					
			console.log(data);
			$.each(data, function(building_name, value_list){
				var random_color = '#'+Math.floor(Math.random()*16777215).toString(16);
				var dataset = {
		            label: building_name,
		            fill: false,
		            backgroundColor: random_color,
		            lineTension: 0.3,
		            borderWidth: 1,
		            borderColor: random_color,
		            data: []
		        };

		        $.each(chart_data.labels, function(key, label){
		        	y = 0;
		        	$.each(value_list, function(key, item){
		        		if(label == item.label) {
		        			y = item.val;
		        		}
		        	})
		        	dataset.data.push(y);
		        });
		        chart_data.datasets.push(dataset);
			});
			var lineChart = new Chart(ctx, {
			    type: "line",
			    data: chart_data,
			    options: {}
			});
		}

		function init_chart1() {
			var none_datasets = [{
	            label: "None",
	            fill: false,
	            lineTension: 0.3,
	            borderColor: "gray",
	            backgroundColor: "gray",
	            borderWidth: 1,
	            data: [0,0]
	        }];
			var line_ctx = $("#rental_price_trend_over_time canvas");
			var line_data = {
			    labels: ["none","none"],
			    datasets: none_datasets
			};
			var lineChart = new Chart(line_ctx, {
			    type: 'line',
			    data: line_data,
			    options: {}
			});
		}
	}

	// Clustered Building Rent
	if(document.getElementById('barChart')){

		var alternative_view2 = "gross";
    	var all_data2          = {};

		// init checkbox unchecked
		$("#clustered_building_rent input").attr("checked", false);

		// immediate filter set
		$("#clustered_building_rent .set_gross").on("click", function(e){
			alternative_view2 = "gross";
			draw_chart2(all_data2);
		});
		$("#clustered_building_rent .set_net").on("click", function(e){
			alternative_view2 = "net";
			draw_chart2(all_data2);
		});

		// init chart view - none
		init_chart2();

		// apply filter
		$('#clustered_building_rent .apply-filter').on("click", function(e){
			var filter_list = [];
			$("#clustered_building_rent input").each(function(){
				if(this.checked){
					filter_list.push(this.value)
				}
			});
			var from_date = $.datepicker.formatDate("dd-mm-yy",from.datepicker("getDate"));
			var to_date   = $.datepicker.formatDate("dd-mm-yy",to.datepicker("getDate"));

			$.get( "/analyses/ppsf_filter2",
				{
					from_date   : from_date,
					to_date     : to_date,
					filter_list : filter_list
				},
				function( result ) {
					all_data2 = result;
					draw_chart2();
				}
			);
		});

		// start - end date
		var dateFormat = "mm/dd/yy";
		var from = $("#from")
			.datepicker({
				defaultDate: "+1w",
				changeMonth: true,
				changeYear: true,
				numberOfMonths: 1
			})
			.on("change", function() {
				to.datepicker( "option", "minDate", getDate( this ) );
			});
		var to = $( "#to" )
			.datepicker({
				defaultDate: "+1w",
				changeMonth: true,
				changeYear: true,
				numberOfMonths: 1
			})
			.on("change", function() {
				from.datepicker( "option", "maxDate", getDate( this ) );
			});
		var from_day = new Date(), to_day = from_day.setDate(from_day.getDate() - 30);
		to.datepicker("setDate", to_day);
		from.datepicker("setDate", from_day);
		to.datepicker("option", "maxDate", new Date());
		from.datepicker("option", "maxDate", new Date());

		function getDate( element ) {
			var date;
			try {
				date = $.datepicker.parseDate( dateFormat, element.value );
			} catch( error ) {
				date = null;
			}
			return date;
		}

		function init_chart2() {
			var bar_ctx = $("#barChart");

			var barData = {
		    labels: ["Chocolate", "Vanilla", "Strawberry"],
			    datasets: [
			        {
			            label: "Blue",
			            backgroundColor: "blue",
			            data: [2,3]
			        },
			        {
			            label: "Red",
			            backgroundColor: "red",
			            data: [1]
			        },
			        {
			            label: "Green",
			            backgroundColor: "green",
			            data: [3]
			        }
			    ]
			};

			var barOptions = {
				scaleStartValue : 0,
				scales: {
		            xAxes: [{
		                    barPercentage: 0.8
		            }],
		            yAxes: [{
		            	ticks: {
		                    min: 0
		            	}
		            }]
		        }
			};

			var barChart = new Chart(bar_ctx, {
			    type: 'bar',
			    data: barData,
			    options: barOptions
			});
		}

		function draw_chart2() {
			$("#clustered_building_rent .chart-container").html('<canvas width="400" height="200"></canvas>');
			var ctx = $("#clustered_building_rent canvas");
			var data;
			var chart_data = {
				labels: [],
				datasets: [{
					label : "hey",
					backgroundColor : [],
					data : []
				}]
			}

			switch (alternative_view2){
				case "gross":
					data = all_data2.data.gross
					break;
				case "net":
					data = all_data2.data.net
					break;
			}

			console.log(data);
			$.each(data, function(index, item){

				chart_data.labels.push(item.geo);

				var random_color = '#'+Math.floor(Math.random()*16777215).toString(16);
				chart_data.datasets[0].backgroundColor.push(random_color);
				chart_data.datasets[0].data.push(item.val);
			});

			var barOptions = {
				scaleStartValue : 0,
				scales: {
		            xAxes: [{
		                    barPercentage: 0.8
		            }],
		            yAxes: [{
		            	ticks: {
		                    min: 0
		            	}
		            }]
		        }
			};

			var barChart = new Chart(ctx, {
			    type: 'bar',
			    data: chart_data,
			    options: barOptions
			});
		}
	}
} );