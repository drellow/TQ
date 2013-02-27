
$(document).ready(function() {

  $('.answer-form').bind('ajax:success', function() {
    $('.current-user-answer').addClass('answered');
  });

  $('.edit-answer').click(function() {
    $('.current-user-answer').removeClass('answered');
  });

  $('.answer-header form').bind('ajax:success', function(event, data) {
    $(this).closest('.answer-header').find('.user-score').html(data.answer_score);
    $('#current_user_score').html(data.user_score);
  })

  $('.show-comments').click(function() {
    $(this).parent().addClass('comments-on');
    $(this).parent().parent().find('.comments').addClass('comments-on');
  })

  $('.hide-comments').click(function() {
    $(this).parent().removeClass('comments-on');
    $(this).parent().parent().find('.comment-toggle').removeClass('comments-on');
  })
});
