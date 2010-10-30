$(document).ready(function(){
  function search() {
    $("#q").addClass("loading");
    var form = $("#twitter_search");
    var url = "/home/search.js";
    var formData = form.serialize();
    
    $.get(url, formData, function(result) { 
      $("#search-results").html(result);
    });
  }

$("#q").bind("keyup", function() {
    clearTimeout($.data(this, 'timer'));
    var wait = setTimeout(search, 1000);
    $(this).data('timer', wait);
  });

$("#intro-video").hide();

$(".video-toggle").click( function() {
  $("#intro-video").toggle('fast');
  });
});
