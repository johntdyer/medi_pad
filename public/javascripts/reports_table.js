  function debug(){ if( window.console && window.console.log ) console.log(arguments); }

    $(document).ready(function (){  // on DOM ready

      // Hide recorded charges by default
      $('.patient_charge').each(function(){
        if($(this).find('.recorded').text()=="true"){$(this).hide();  }
      });
        
      $(".group").iButton({
        init: function (){
          debug("init", arguments);
        }, 
        change: function (){
          if ($('#ex02').attr('checked')) {
            console.info("Hide Toggle");
            var is_checked = true;
            $('.patient_charge').each(function(){
              if($(this).find('.recorded').text()=="true"){ $(this).hide(); }
            });
          }else{
            console.info("Show Toggle");
            var is_checked = false;
            $('.patient_charge').each(function(){
              if($(this).find('.recorded').text()=="true"){   $(this).show(); }
            });
          }
        }
      });
      
      $(".record_charge_button").click(function(){
        var record_edited=new Object(); 
        var response={}
        var charge={}
        record_edited.charge_id = $(this).parents().find('.patient_name').attr('patientId');
        
        if($(this).parents().find('.recorded').first().text()=="true"){
          $(this).parents().find('.recorded').first().text("false");
          charge.recorded = false
        }
        else{
          $(this).parents().find('.recorded').first().text("true");
          charge.recorded = true
        } 
        
 
        response.id=$(this).parents().find('.patient_name').attr('patientId');
        response.charge=charge
        
        $.ajax({
          type: "POST",
          url: "/charges/update",
          dataType:'json',
          data: response,
          success: function(msg){
            console.info( "Post 200OK \n\t{'charge_status':'"+record_edited.is_recorded+"','charge_id':'"+record_edited.charge_id+"'}");
          }
        });
      });
      $("#ex10")  // attach the iButton behavior
      .iButton({
        labelOn: "Off",
        labelOff: "On"
      })      // trigger the change event (to update the text)
    .trigger("change");
  });

  $("#button_test").click(function(){
    $('.patient_charge').each(function(){
      if($(this).find('.recorded').text()=="true"){$(this).hide();  }
    });
  });