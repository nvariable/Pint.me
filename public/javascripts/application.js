$(document).ready(function(){
  $("#q").bind("keyup", function() {
    $("#q").addClass("loading");
    var form = $("#twitter_search");
    var url = "/home/search";
    var formData = form.serialize();
    $.get(url, formData, function(html) { 
      $("#twitter_search").removeClass("loading"); 
      $("#search-results").html(html);
    });
  });
});



