$(document).ready(function() {
  $('#person').DataTable();
  $('#more').DataTable();
  $('#lay').DataTable();
  $('#laymore').DataTable();
  $('#exinv').DataTable();
  $('#delv').DataTable();
});

$(document).ready(function() {
  $(".alert" ).fadeOut(5000);
  $(".notice" ).fadeOut(5000);
  $(".error" ).fadeOut(5000);
});
$(document).ready(function() {
  $(function() {
    $('a#show_delivery').click(function(event){
      event.preventDefault();
      $('div#delivery').toggle();
    });
  });
});
$(document).ready(function() {
  $(function() {
    $('a#show_items').click(function(event){
      event.preventDefault();
      $('div#items').toggle();
    });
  });
});
$(document).ready(function() {
  $(function() {
    $('a#show_pays').click(function(event){
      event.preventDefault();
      $('div#pays').toggle();
    });
  });
});
$(document).ready(function() {
  $(function() {
    $('a#show_laydelivery').click(function(event){
      event.preventDefault();
      $('div#laydelivery').toggle();
    });
  });
});
$(document).ready(function() {
  $(function() {
    $('a#show_layitems').click(function(event){
      event.preventDefault();
      $('div#layitems').toggle();
    });
  });
});
$(document).ready(function() {
  $(function() {
    $('a#show_laypays').click(function(event){
      event.preventDefault();
      $('div#laypays').toggle();
    });
  });
});
$(document).ready(function() {
  $(function() {
    $('a#show_dlv').click(function(event){
      event.preventDefault();
      $('div#dlv').toggle();
    });
  });
});
$(document).ready(function() {
  $(function() {
    $('a#show_exitems').click(function(event){
      event.preventDefault();
      $('div#exitems').toggle();
    });
  });
});
