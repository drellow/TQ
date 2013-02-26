
$(document).ready(function() {

  $('.answer-form').bind('ajax:success', function() {
    $('.current-user-answer').addClass('answered');
  });

  $('.edit-answer').click(function() {
    $('.current-user-answer').removeClass('answered');
    console.log("clicked!");
  });

  $('.answer-header form').bind('ajax:success', function(event, data) {
    $(this).closest('.answer-header').find('.user-score').html(data.answer_score);
    $('#current_user_score').html(data.user_score);
  })
});
