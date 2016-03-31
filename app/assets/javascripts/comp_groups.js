(function(){
  var _getDatatableScrollHeight = function() {
    return window.innerHeight - $('#comp-table').offset().top - 2;
  }

  window.addEventListener('load', function(){
    var compDatatable = $('#comp-table').dataTable({
      paging: false,
      scrollY: _getDatatableScrollHeight(),
      scrollCollapse: true,
      fixedHeader: true,
      scrollX: true,
      info: false,
      ordering: false,
      searching: false,
      initComplete: function(settings, json) {
        settings.oScroll.sY = _getDatatableScrollHeight();
        this.api().draw();
      }
    });

    window.addEventListener('resize', function(){
      compDatatable.fnSettings().oScroll.sY = _getDatatableScrollHeight();
      compDatatable.api().draw();
    });
  });
})();