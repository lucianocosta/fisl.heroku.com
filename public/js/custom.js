
$(document).ready(function(){

  $('.info_box').fadeIn('slow').delay(2300).fadeOut('slow');

  /*-- hide info boxes --*/
  $('.close').click(function() {
    $(this).parent('.info_box').fadeOut('slow');
  });
  
});
