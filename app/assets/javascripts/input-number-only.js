(function() {
  // Will come back to this...
  return;

  var _restrictToNumber = function(e) {
    var value = this.value;
    this.value = value.replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
  }

  var init = function() {
    var numberOnlyInputs = document.querySelectorAll('.js-only-number');

    if (!numberOnlyInputs.length) {
      return;
    }

    for (var i = 0; i < numberOnlyInputs.length; i++) {
      numberOnlyInputs[i].addEventListener('keyup', _restrictToNumber);
    };
  };

  window.addEventListener('load', init);
})();