(function(){
  function init() {
    var form = document.getElementById('new_building_occupancy');

    if (form) {
      $('.datepicker').datepicker({
        dateFormat: 'dd-mm-yy'
      });

      document.querySelector('.btn-save-continue').addEventListener('click', function(e){
        e.preventDefault();
        $(form).find('#add_another').attr('checked', true);
        form.submit();
      });
    }

    if ($('.building-occupancy-table').length) {
      var occupancyDatatable = $('.building-occupancy-table').dataTable({
        aoColumnDefs: [
          { bSortable: false, aTargets: [ 'no-sort' ] }
        ],
        bPaginate: false,
        bInfo: false,
        bFilter: false
      });
    }
  }

  window.addEventListener('load', init);
})();