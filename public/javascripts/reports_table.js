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
        record_edited.charge_id = $(this).parents().find('.patient_name').attr('patientId');
        
        if($(this).parents().find('.recorded').first().text()=="true"){
          $(this).parents().find('.recorded').first().text("false");
          record_edited.is_recorded = false
        }
        else{
          $(this).parents().find('.recorded').first().text("true");
          record_edited.is_recorded = true
        }
        $.ajax({
          type: "POST",
          url: "/charges/update_charge_status",
          data: "charge_status="+record_edited.is_recorded+"&charge_id="+record_edited.charge_id,
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