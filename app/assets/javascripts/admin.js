//= require jquery.min
//= require jquery.ui.dialog
//= require jquery_ujs
//= require jquery.countdown
//= require jquery.KinSlideshow
//= require jquery.chained.remote.min
//= require jquery-fileupload/basic
//= require tmpl.min
//= require ajax
function clickableLabel(){
    $("input[data-clickable=true]").each(function(){
        var label = $("label[for="+$(this).attr("id")+"]").addClass("clickable").click(function(){ $(this).toggleClass("checked")});
        if($(this).attr("checked")) label.click();
    }).css("visibility", "hidden").css("width", "1px"); //w operze nie moze byc hide()
}

function clickableLabelClear(){
    $("input[data-clickable=true]:checked").each(function(){
        $("label[for=" + $(this).attr("id") + "]").click();
        $(this).click();
    });
    return !true;
}

function sizableFieldset(){
    $("fieldset[data-sizable=true] > legend").each(function(){
        $(this).click(function(){ $(this).parent().children().not(":first").toggle("fast")});
    });//.click(); //odznaczyc jesli maja sie chowac sekcje
}
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
