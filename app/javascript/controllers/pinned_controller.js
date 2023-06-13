
document.addEventListener('DOMContentLoaded', function() {
  var pinIcons = document.querySelectorAll('.pin-icon');
  pinIcons.forEach(function(pinIcon) {
    pinIcon.addEventListener('click', function() {
      var routeId = this.dataset.routeId;
      localStorage.setItem('pinnedRoute', routeId);
    });
  });
});
