(function(){
  var init = function() {

    if (document.getElementById('js-save-and-add')) {
      document.getElementById('js-save-and-add').addEventListener('click', function(e) {
        e.preventDefault();
        var $form = $(e.currentTarget).closest('form');
        var $checkbox = $form.find('#building_unit_move_in');
        var $submitButton = $form.find('input[type="submit"]');
        $checkbox[0].checked = 'checked';
        $submitButton.click();
      });
    }

    if (document.getElementById('comp-index-table')) {
      $('#comp-index-table').dataTable({
        "aoColumnDefs": [
          { "bSortable": false, "aTargets": [ 1, 2, 3, 4, 5, 6, 7, 8, 11 ] }
        ],
        bPaginate: false,
        bInfo: false,
        bFilter: false
      });
    }
  }

  window.addEventListener('load', init);
})()