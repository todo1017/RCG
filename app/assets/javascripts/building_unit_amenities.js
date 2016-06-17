(function(){
  var init = function() {

    if (document.getElementById('js-save-building-unit-amenities')) {
      document.getElementById('js-save-building-unit-amenities').addEventListener('click', function(e) {
        e.preventDefault();
        var $form = $(e.currentTarget).closest('form');
        var $formAction = $form.attr('action');
        $form.attr('action', $formAction + '?redirect=false');
        var $submitButton = $form.find('input[type="submit"]');
        $submitButton.click();
      });
    }
  }

  window.addEventListener('load', init);
})()