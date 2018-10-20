var X;
var Y;
var li_size;
var int_val;
var permition = true;
var height_size;
var li_child;
var main_nav;
var coloring;
var back = true;
var null_;
var part = 0;

$(document).ready(function(){

	main_nav = $('div.navigation>ul').html();                                                   //Main Navigation HTML
	$('div.navigation>div').html($('div.navigation>div').html() + '<div id = "back"></div>');   // Back button
	
	
	/** (div.navigation>ul>li).click() **/
	$("div.navigation>ul>li").live('click', function(){
	
		if(permition == true && $(this).children('ul').html().length){
			
			int_val = 300;
			Y =  $(this).children("a").html();
			li_size = $("div.navigation>ul>li").size();
						
			for(i = 1; i <= li_size; i++){		
				
				X = $("div.navigation>ul>li:nth-child(" + String(i) +")").children("a").html();	
						if(X != Y){
							$("div.navigation>ul>li:nth-child(" + String(i) +")").addClass('animated flipIn_left');
						} 
						setTimeout(function(){
							$("div.navigation>ul>li:nth-child(" + String(i) +")").removeClass('animated flipIn_left');
						}, int_val);
							
					int_val = 300 * i;
					
			} // /End for
			$('div.navigation>ul').animate({opacity : '0.1', marginLeft : '40px'}, 600);  
			  
			$("div.navigation>div>span").animate({opacity : '0.1', top : '-10px'}, 600, function(){
				//$("div.navigation>div>span").html(Y);
				$("div.navigation>div>span").html(Y.substring(0,Y.indexOf(".png"))+"2"+Y.substring(Y.indexOf(".png")));
				$("div.navigation>div>span").animate({opacity : '1', top : '0px'}, 600);
			});
	
			permition = false;
			back = true;
			li_child = $(this).children('ul').html();
			
			coloring = $(this).css("background-color"); // color variable use
			setTimeout(function(){
				$('div.navigation>ul').html(li_child);
				$('div#back').show(300);
				$('div.navigation>ul>li').css('background-color', coloring); // Coloring li
				$('div.navigation>ul').animate({opacity : '1', marginLeft : '0px'}, 600);
				$('div.navigation>ul>li').addClass('animated flipIn_right_back');
				
				setTimeout(function(){
						$('div.navigation>ul>li').removeClass('animated flipIn_right_back');
					}, 600);
			}, 600);
			
		}
	}); /** /End (div.navigation>ul>li).click() **/

	
	/** li mouse Leave **/
	$("div.navigation>ul>li").live('mouseleave', function(){
		
		$(this).removeClass('animated flipIn_right');
		$(this).removeClass('animated flipIn_left');
		$(this).removeClass('animated flipIn_top');
		$(this).removeClass('animated flipIn_bottom');
		$(this).removeClass('do');
		part = 0;
		
	}); /** /End li mouse Leave **/
	
	
	/** Mouse move **/
	$("div.navigation>ul>li").live( 'mousemove', function(e){
	
	// For Chome and Safari
	/**
	if($.browser.webkit){
		if(part != 5){
			$(this).addClass('do');
			part = 5;
		}
	}
	
	 // for IE, Mozilla, Opera
	else{
	**/
		if(((e.clientY - $(this).offset().top) / (e.clientX - $(this).offset().left)) < 1){
		
		// for Right Triangle	
			if(( (e.clientY - $(this).offset().top) /  ($(this).width() - (e.clientX - $(this).offset().left))  ) > 1 ){
				
				if(part != 1){
					// For Right Turn
						$(this).removeClass('animated flipIn_bottom');
						$(this).removeClass('animated flipIn_top');
						$(this).removeClass('animated flipIn_right');
						$(this).addClass('animated flipIn_right');
						part = 1;
				}
			}
			else{
				
				if(part != 2){
					// For Top Turn
						$(this).removeClass('animated flipIn_bottom');
						$(this).removeClass('animated flipIn_right');
						$(this).removeClass('animated flipIn_left');
						$(this).addClass('animated flipIn_top');
						part  = 2;
				}
			}

		}

		else if(((e.clientY - $(this).offset().top) / (e.clientX - $(this).offset().left)) > 1){

				// for Left Triangle
			if(( (e.clientX - $(this).offset().left) /  ($(this).height() - (e.clientY - $(this).offset().top)))  > 1  ){
					
					if(part != 3){
						// For bottom Turn
							$(this).removeClass('animated flipIn_top');
							$(this).removeClass('animated flipIn_left');
							$(this).removeClass('animated flipIn_right');
							$(this).addClass('animated flipIn_bottom');		
							part = 3;
					}
			}
			else{
					
					if(part != 4){
						// For Left Turn
							$(this).removeClass('animated flipIn_top');
							$(this).removeClass('animated flipIn_right');
							$(this).removeClass('animated flipIn_bottom');
							$(this).addClass('animated flipIn_left');	
							part = 4;
					}
			}
			
		}
		
		else{
	
			// Other wise
				$(this).removeClass('animated flipIn_right');
				$(this).removeClass('animated flipIn_left');
				$(this).removeClass('animated flipIn_top');
				$(this).removeClass('animated flipIn_bottom');
				part = 0;
		}
	//}	
	});/** /Mouse Move End **/
	
	
	/** Back Mouse enter **/
	$("div#back").mouseenter(function(){
		$('div#back').css('background-position', '50px -50px');
	});
	
	
	/** Back Mouse Leave **/
	$("div#back").mouseleave(function(){
		$('div#back').css('background-position', '0px 0px');
	});
	
	
	/** Back Mouse Down **/
	$("div#back").mousedown(function(){
		$('div#back').css('background-position', '50px -100px');
	});
	
	
	/** Back Mouse Up **/
	$("div#back").mouseup(function(){
		$('div#back').css('background-position', '50px -50px');
	});
	
	
	/** div#back click **/
	$("div#back").live('click', function(){
	
		if(back == true){
			$('div.navigation>ul>li').addClass('animated flipIn_left');
			$('div.navigation>ul').animate({opacity : '0.1', marginLeft : '40px'}, 400);
		
			setTimeout(function(){
			
				$('div.navigation>ul').removeClass('animated flipIn_left');
				$('div.navigation>ul').html(main_nav);
				
				$('div.navigation>ul>li').addClass('animated flipIn_right_back');
				
				$('div.navigation>ul').animate({opacity : '1', marginLeft : '0px'}, 600);
				$("div#back").hide(300);
				
					setTimeout(function(){
						$('div.navigation>ul>li').removeClass('animated flipIn_right_back');
					}, 400);
				
			}, 400);
			
			permition = true;
			
			$("div.navigation>div>span").animate({opacity : '0.1', top : '-10px'}, 600, function(){
					$("div.navigation>div>span").html('');//Home
					$("div.navigation>div>span").animate({opacity : '1', top : '0px'}, 600);
			});		
			
			back = false;
		}	
	}); /** /End div#back click **/
	
});