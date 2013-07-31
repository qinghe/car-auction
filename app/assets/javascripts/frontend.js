//= require jquery.min
//= require jquery.ui.dialog
//= require jquery_ujs
//= require jquery.countdown
//= require jquery.KinSlideshow
//= require ajax

// Javascript
$(function() {
  $("#vercode_button").click(function(){
    $this = $(this);
    $this.text("重新获取");// 已发送，1分钟后可重新获取。
    ajax_post('/sessions/get_vercode','new_user_form')
    $this.attr("disabled",true);  
    $this.countdown(0,60*1000, function(event) {   
        switch(event.type) {
          case "seconds":
            $this.text("验证码已发送，"+event.value+"秒后可重新获取")
            break;
          case "finished":
            $this.attr("disabled",false);  
            $this.text("重新获取")            
            break;
        }
      })
    }    
  )
})