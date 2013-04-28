// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .
//= require jquery.simplecolorpicker.js

$(document).ready(function() {

  var commentsBox = $($('.comment')[0]).clone();

  $('.answer-form').bind('ajax:success', function() {
    $('.current-user-answer').addClass('answered');
  });

  $('.new-title').click(function() {
    $.getJSON('/silly_title', function(data) {
      $('#user_title').val(data.title);
    });
  })

  $('.new_comment').bind('ajax:success', function(event, data) {
    $(this).closest('.comments').find('.comment-collection').append(data);
    $(this).find('textarea').val('');
  })

  $('.edit-answer').click(function() {
    $('.current-user-answer').removeClass('answered');
  });

  $('.answer-header form').bind('ajax:success', function(event, data) {
    $(this).closest('.answer-header').find('.user-score').html(data.answer_score);
    $('#current_user_score').html(data.user_score);
  });
  
  $('.suggestion form').bind('ajax:success', function(event, data) {
    $(this).closest('.suggestion').find('.suggestion-score').html(data.suggestion_score);
    $('#current_user_score').html(data.user_score)
  })

  $('.show-comments').click(function() {
    $(this).parent().addClass('comments-on');
    $(this).parent().parent().find('.comments').addClass('comments-on');
  })

  $('.hide-comments').click(function() {
    $(this).parent().removeClass('comments-on');
    $(this).parent().parent().find('.comment-toggle').removeClass('comments-on');
  })

  $('.show-change-password').click(function() {
    $('.change-password-info').addClass('change-password-on');
    $('.show-change-password').addClass('change-password-on');
  })

  $('.hide-change-password').click(function() {
    $('.change-password-info').removeClass('change-password-on');
    $('.show-change-password').removeClass('change-password-on');
  })

  $('select[name="colorpicker"]').simplecolorpicker();


  $('select[name="user[color]"]').simplecolorpicker();


  $(".alerts").click(function() {
    $('.alerts').slideUp('slow', 'swing');
  })
});
