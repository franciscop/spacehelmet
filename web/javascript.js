$(document).ready(function(){
  setInterval(function(){
    $.getJSON("http://spacehelmet.info/data/data.txt", function(data) {
      //$(".temperature span").html(data.temp);
      //$(".sun span").html(data.ldr);
      
      $("h1").html(data.show);
      
      var val = Math.random() * 10 + 10;
      var top = parseInt($(".lungs_blue").css("top"));
      
      if (top > 280)
        {
        $(".lungs_blue img").attr("src", "/lungs_blue.png");
        top = 0;
        }
      
      console.log(top);
      $(".lungs_blue").css("top", top + val);
      $(".lungs_blue img").css("margin-top", - top - val);
      
      if (top > 150)
        {
        $(".lungs_blue img").attr("src", "/lungs_yellow.png");
        }
      
      if (top > 200)
        {
        $(".lungs_blue img").attr("src", "/lungs_red.png");
        }
      });
    
    $(".sun span").html(parseInt(Math.random() * 7 + 7));
    $(".pressure span").html((Math.random() * 0.5 + 0.75).toFixed(1));
    $(".temperature span").html((Math.random() * 5 + 25).toFixed(1));
    },
    1000);
  
  });
