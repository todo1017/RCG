(function(){
	function init() {
		var form = document.getElementById('new_building_occupancy');

		if (!form) {
			return;
		}

		$('.datepicker').datepicker({
			dateFormat: 'dd-mm-yy'
		});

		document.querySelector('.btn-save-continue').addEventListener('click', function(e){
			e.preventDefault();
			$(form).find('#add_another').attr('checked', true);
			form.submit();
		});
	}

	window.addEventListener('load', init);
})();