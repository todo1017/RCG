(function(){
	var init = function() {
		if (!document.getElementById('js-save-and-add')) {
			return;
		};

		document.getElementById('js-save-and-add').addEventListener('click', function(e) {
			e.preventDefault();
			var $form = $(e.currentTarget).closest('form');
			var $checkbox = $form.find('#building_unit_move_in');
			var $submitButton = $form.find('input[type="submit"]');
			$checkbox[0].checked = 'checked';
			$submitButton.click();
		});
	}

	window.addEventListener('load', init);
})()