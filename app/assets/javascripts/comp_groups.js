(function(){
  var _getDatatableScrollHeight = function() {
    return window.innerHeight - $('#comp-table').offset().top;
  }

  window.addEventListener('load', function(){
    if (!$('#comp-table').length) {
      return;
    };

    var compDatatable = $('#comp-table').dataTable({
      bSort: false,
      aoColumnDefs: [
        { bSortable: false, aTargets: [ 'no-sort' ] }
      ],
      bPaginate: false,
      sScrollX: "100%",
      sScrollXInner: "200%",
      sScrollY: _getDatatableScrollHeight(),
      bInfo: false,
      bFilter: false,
      fnInitComplete: function(settings, json) {
        $('.dataTables_scrollBody').css('height', _getDatatableScrollHeight());
      }
    });

    new $.fn.dataTable.FixedColumns(compDatatable, { "iLeftColumns": 7 });

    window.addEventListener('resize', function(){
      $('.dataTables_scrollBody').css('height', _getDatatableScrollHeight());
    });
  });
})();