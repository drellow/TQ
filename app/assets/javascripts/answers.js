
$(document).ready(function() {

  $('.answer-form').bind('ajax:success', function() {
    $('.current-user-answer').addClass('answered');
  });

  $('.edit-answer').click(function() {
    $('.current-user-answer').removeClass('answered');
    console.log("clicked!");
  });
});