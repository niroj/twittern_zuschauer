$(document).ready(function(){
  $(document).on('ajax:beforeSend', '.tweets_search_form', function(){
    $(this).find('input').blur();
    $('.tweets').html('loading ....')
  });
});
